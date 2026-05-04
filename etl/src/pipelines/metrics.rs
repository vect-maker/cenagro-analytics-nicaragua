use crate::transformers;
use anyhow::Result;
use datafusion::prelude::*;

pub async fn run_metrics_pipeline(_ctx: &SessionContext, df: DataFrame) -> Result<DataFrame> {
    // apply metrics
    let df = transformers::metrics::apply_labor_intensity(df)?;
    let df = transformers::metrics::apply_labor_ratios(df)?;
    let df = transformers::metrics::apply_land_use_composition_ratio(df)?;
    let df = transformers::metrics::apply_diversification_index(df)?;
    let df = transformers::metrics::apply_pasture_to_crop_ratio(df)?;

    Ok(df)
}
