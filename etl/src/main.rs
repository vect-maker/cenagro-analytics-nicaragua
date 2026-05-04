use anyhow::Result;
use datafusion::prelude::*;
use etl::env;
use etl::pipelines;
use etl::saver;
use std::time::Instant;

#[global_allocator]
static ALLOC: snmalloc_rs::SnMalloc = snmalloc_rs::SnMalloc;

#[tokio::main]
async fn main() -> Result<()> {
    println!("Starting processing of data");
    let timer = Instant::now();

    // get env varibles
    let app_config = env::load_config()?;
    let ctx = SessionContext::new();

    // run pipelines
    let farms =
        pipelines::farms::run_farms_pipeline(&ctx, &app_config.farms_path, &app_config.out_dir)
            .await?;
    let parcels = pipelines::parcels::run_parcels_pipeline(
        &ctx,
        &app_config.parcels_path,
        &app_config.out_dir,
    )
    .await?;

    let farms = pipelines::dataset_join::run_dataset_join_pipeline(&ctx, farms, parcels).await?;

    let farms = pipelines::metrics::run_metrics_pipeline(&ctx, farms).await?;

    // save the data
    saver::save_data(
        farms.clone(),
        &format!("{}/{}", &app_config.out_dir, "farms.parquet"),
    )
    .await?;

    println!("Finished processing");
    println!("Pipeline execution time: {:?}", timer.elapsed());

    Ok(())
}
