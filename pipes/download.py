import os
import sys
import requests
from tqdm import tqdm

DATA_DIR = "data"

SOURCES = [
    (
        "https://www.inide.gob.ni/docs/dataBases/BaseIVCenagro/Cenagro%202011%2001%20Explotaciones%20Agropecuarias.sav",
        "cenagro-2011-explotaciones-agropecuarias.sav",
    ),
    (
        "https://www.inide.gob.ni/docs/dataBases/BaseIVCenagro/Cenagro%202011%2029%20Parcelas-Tenencia.sav",
        "cenagro-2011-parcelas-tenencia.sav",
    ),
    (
        "https://www.inide.gob.ni/docs/dataBases/BaseIVCenagro/Cenagro%202011%2034%20Parcelas-Aprovechamiento%20de%20la%20tierra.sav",
        "cenagro-2011-parcelas-aprovechamiento-tierra.sav",
    ),
]


def download(url: str, dest_path: str):
    headers = {"User-Agent": "Mozilla/5.0"}
    res = requests.get(url, headers=headers, stream=True, timeout=60)
    res.raise_for_status()

    total = int(res.headers.get("content-length", 0))
    temp_path = f"{dest_path}.tmp"

    with open(temp_path, "wb") as f, tqdm(
        desc=os.path.basename(dest_path),
        total=total if total > 0 else None,
        unit="iB",
        unit_scale=True,
    ) as bar:
        for chunk in res.iter_content(chunk_size=1024 * 1024):
            if chunk:
                f.write(chunk)
                bar.update(len(chunk))

    os.replace(temp_path, dest_path)


def main():
    force = "--force" in sys.argv or "-f" in sys.argv
    os.makedirs(DATA_DIR, exist_ok=True)

    for url, filename in SOURCES:
        dest = os.path.join(DATA_DIR, filename)
        if os.path.exists(dest) and not force:
            print(f"Skipping {filename} (already exists)")
            continue

        print(f"Downloading {filename}...")
        download(url, dest)


if __name__ == "__main__":
    main()
