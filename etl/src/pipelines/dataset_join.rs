use crate::mappings::composite_key::COMPOSITE_KEY;

use crate::transformers;
use anyhow::Result;
use datafusion::prelude::*;

pub async fn run_dataset_join_pipeline(
    _ctx: &SessionContext,
    farms_df: DataFrame,
    parcels_df: DataFrame,
) -> Result<DataFrame> {
    let parcels_df = transformers::parcels::aggregate_parcels_by_composite_key(parcels_df).await?;

    let joined_df = farms_df.alias("farms")?.join(
        parcels_df.alias("parcels")?,
        JoinType::Inner,
        &COMPOSITE_KEY,
        &COMPOSITE_KEY,
        None,
    )?;

    let projection: Vec<Expr> = joined_df
        .schema()
        .iter()
        .filter_map(|(qualifier, field)| {
            let name = field.name();
            let q_str = qualifier.map(|q| q.to_string());

            match q_str {
                Some(q) if q == "farms" => Some(col(format!("{}.{}", q, name)).alias(name)),

                Some(q) if q == "parcels" && !COMPOSITE_KEY.contains(&name.as_str()) => {
                    Some(col(format!("{}.{}", q, name)).alias(name))
                }
                _ => None,
            }
        })
        .collect();

    let df = joined_df.select(projection)?;

    let df = transformers::farms::apply_surrogate_key(df)?;

    Ok(df)
}
