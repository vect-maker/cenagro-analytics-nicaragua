import json
import os
import sys
import pyreadstat


def convert_to_parquet(spss_file, file_name, outdir="data"):
    if not os.path.exists(spss_file):
        print(f"Skipping {spss_file}: file does not exist.")
        return

    os.makedirs(outdir, exist_ok=True)
    print(f"Converting '{spss_file}' to Parquet and JSON metadata in '{outdir}'...")

    # Open the file
    df, meta = pyreadstat.read_sav(spss_file, apply_value_formats=False)

    meta_path = os.path.join(outdir, f"{file_name}-metadata.json")
    # Save metadata
    with open(meta_path, "w", encoding="utf-8") as f:
        json.dump(
            {
                "variable_value_labels": meta.variable_value_labels,
                "column_names_to_labels": meta.column_names_to_labels,
            },
            f,
            ensure_ascii=False,
            indent=4,
        )

    # Save to parquet
    parquet_path = os.path.join(outdir, f"{file_name}.parquet")
    df.to_parquet(parquet_path, engine="pyarrow", index=False)
    print(f"✓ Created {parquet_path} ({df.shape[0]} rows, {df.shape[1]} columns)")
    print(f"✓ Created {meta_path}")


def main():
    target_files = [
        ("data/cenagro-2011-explotaciones-agropecuarias.sav", "cenagro-2011-explotaciones-agropecuarias"),
        ("data/cenagro-2011-parcelas-aprovechamiento-tierra.sav", "cenagro-2011-parcelas-aprovechamiento-tierra"),
        ("data/cenagro-2011-parcelas-tenencia.sav", "cenagro-2011-parcelas-tenencia"),
    ]

    converted_any = False
    for spss_path, name in target_files:
        if os.path.exists(spss_path):
            convert_to_parquet(spss_path, name, "data")
            converted_any = True

    if not converted_any:
        print(
            "No source .sav files found in 'data/' to convert.\n"
            "Run 'just download-data' or 'python3 pipes/download.py' first.",
            file=sys.stderr,
        )


if __name__ == "__main__":
    main()
