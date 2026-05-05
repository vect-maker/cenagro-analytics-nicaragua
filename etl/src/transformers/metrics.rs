use crate::dataframe::DataFrameExt;
use anyhow::{Context, Result};
use datafusion::arrow::datatypes::DataType;
use datafusion::prelude::*;

const CATEGORIES_MZ: [&str; 8] = [
    "mz_annual_crops",
    "mz_permanent_crops",
    "mz_cultivated_pasture",
    "mz_natural_pasture",
    "mz_forest",
    "mz_fallow",
    "mz_infrastructure",
    "mz_unusable",
];

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
    let land_use_composition_ratios = CATEGORIES_MZ
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

// Labor Intensity = (permanent + temporal) / total_area_mz (Threshold: > 0.01 mz)
pub fn apply_labor_intensity(df: DataFrame) -> Result<DataFrame> {
    let total_workers = col("permanent_workers_total") + col("temporal_workers_total");

    let df = df
        .with_column(
            "labor_intensity",
            when(
                col("total_area_mz").gt(lit(0.01f64)),
                cast(total_workers, DataType::Float64) / col("total_area_mz"),
            )
            .otherwise(lit(0.0f64))
            .expect("Failed to build CASE expression for labor intensity"),
        )
        .context("Could not apply labor intensity metric")?;

    Ok(df)
}

// Diversification Index (Índice de Diversificación) = count_if(mz_annual, mz_permanent, mz_pasture, mz_forest > 0)
pub fn apply_diversification_index(df: DataFrame) -> Result<DataFrame> {
    let indicators = CATEGORIES_MZ
        .iter()
        .map(|&cat| {
            when(col(cat).gt(lit(0.0f32)), lit(1u8))
                .otherwise(lit(0u8))
                .expect("Failed to build indicator expression")
        })
        .collect::<Vec<Expr>>();

    let diversification_expr = indicators
        .into_iter()
        .reduce(|acc, e| acc + e)
        .context("Categories list cannot be empty")?
        .alias("diversification_index");

    let df = df
        .with_column("diversification_index", diversification_expr)
        .context("Could not apply diversification index")?;

    Ok(df)
}

// Pasture-to-Crop Ratio (Ratio Pasto-Cultivo) = (mz_cultivated_pasture + mz_natural_pasture) / (mz_annual_crops + mz_permanent_crops)
pub fn apply_pasture_to_crop_ratio(df: DataFrame) -> Result<DataFrame> {
    let total_pasture = col("mz_cultivated_pasture") + col("mz_natural_pasture");
    let total_crops = col("mz_annual_crops") + col("mz_permanent_crops");

    let df = df.with_column(
        "pasture_to_crop_ratio",
        when(
            total_crops.clone().gt(lit(0)),
            cast(total_pasture, DataType::Float32) / cast(total_crops, DataType::Float32),
        )
        .otherwise(lit(0))?,
    )?;

    Ok(df)
}
