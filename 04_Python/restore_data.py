"""Restore the full order table from compressed repository parts."""
from pathlib import Path
import gzip
import hashlib
import shutil
import tempfile

ROOT = Path(__file__).resolve().parents[1]
TARGET = ROOT / "02_Cleaned_Data" / "fact_order.csv"
EXPECTED_SHA256 = "ed9f921ea54e113c6be09eaed1477b700edcc7f1f4365aa695805e071c7fbfef"

def main():
    parts = sorted(TARGET.parent.glob(TARGET.name + ".gz.part*"))
    if not parts:
        raise FileNotFoundError("Download both fact_order.csv.gz.part files first.")
    with tempfile.TemporaryFile() as combined:
        for part in parts:
            with part.open("rb") as source:
                shutil.copyfileobj(source, combined)
        combined.seek(0)
        with gzip.GzipFile(fileobj=combined, mode="rb") as source, TARGET.open("wb") as output:
            shutil.copyfileobj(source, output)
    actual = hashlib.sha256(TARGET.read_bytes()).hexdigest()
    if actual != EXPECTED_SHA256:
        raise ValueError("Restored order table failed its SHA256 integrity check.")
    print(f"Restored and verified: {TARGET}")

if __name__ == "__main__":
    main()
