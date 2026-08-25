#!/usr/bin/env python3

from datetime import datetime, timezone
from pathlib import Path
import re


title = input("title: ").strip()
if not title:
    raise SystemExit("title is required")

slug = re.sub(r"[^a-z0-9]+", "-", title.lower()).strip("-")
if not slug:
    raise SystemExit("title does not contain a URL character")

path = Path("content/blog") / f"{slug}.md"
if path.exists():
    raise SystemExit(f"{path} exists")

date = datetime.now(timezone.utc).date().isoformat()
path.write_text(
    f'---\ntitle: "{title.replace(chr(34), chr(92) + chr(34))}"\n'
    f"date: {date}\ndraft: true\n---\n\n",
    encoding="utf-8",
)
print(path)
