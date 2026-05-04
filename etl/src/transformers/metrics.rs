use crate::dataframe::DataFrameExt;
use anyhow::{Context, Result};
use datafusion::arrow::datatypes::DataType;
use datafusion::prelude::*;

// Permanent Labor Ratio (Proporción de Trabajo Permanente) = permanent_workers_total / (permanent_workers_total + temporal_workers_total)
pub fn apply_labor_ratios(df: DataFrame) -> Result<DataFrame> {
    let total_workers = col("permanent_workers_total") + col("temporal_workers_total");

    let df = df
        .with_column(
            "permanent_labor_ratio",
            when(
                total_workers.clone().gt(lit(0u16)),
                cast(col("permanent_workers_total"), DataType::Float32)
                    / cast(total_workers.clone(), DataType::Float32),
            )
            .otherwise(lit(0.0f32))?,
        )
        .context("Could not apply the labor ratio metric")?;

    Ok(df)
}

// Land Use Composition Ratio (Ratio de Composición de Uso de Suelo) = mz_[categoría] / total_area_mz
pub fn apply_land_use_composition_ratio(df: DataFrame) -> Result<DataFrame> {
    let categories = [
        "mz_annual_crops",
        "mz_permanent_crops",
        "mz_cultivated_pasture",
        "mz_natural_pasture",
        "mz_forest",
        "mz_fallow",
        "mz_infrastructure",
        "mz_unusable",
    ];

    let land_use_composition_ratios = categories
        .iter()
        .map(|&cat| {
            when(
                col("total_area_mz").gt(lit(0.0f32)),
                col(cat) / col("total_area_mz"),
            )
            .otherwise(lit(0.0f32))
            .expect("Failed to build CASE expression for land use ratio")
            .alias(format!("ratio_{}", cat))
        })
        .collect::<Vec<Expr>>();

    let df = df
        .with_columns(land_use_composition_ratios)
        .context("Could not apply land use composition ratio")?;

    Ok(df)
}

// Labor Intensity (Intensidad Laboral) = (permanent_workers_total + temporal_workers_total) / total_area_mz
pub fn apply_labor_intensity(df: DataFrame) -> Result<DataFrame> {
    let total_workers = col("permanent_workers_total") + col("temporal_workers_total");

    let df = df
        .with_column(
            "labor_intensity",
            cast(total_workers.clone(), DataType::Float32)
                / cast(col("total_area_mz"), DataType::Float32),
        )
        .context("Could not apply labor intensity metric")?;
    Ok(df)
}
