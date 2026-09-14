#!/usr/bin/env python3
from pathlib import Path
import json
root=Path(__file__).resolve().parents[1]
files=[
 "src/ts/core/types.ts","src/ts/core/icons.ts","src/ts/data/fixtures.ts",
 "src/ts/components/primitives.ts","src/ts/components/domain.ts",
]
files += [str(p.relative_to(root)) for p in sorted((root/"src/ts/screens").glob("PAT*.ts"))]
files += ["src/ts/main.ts"]
cfg={"compilerOptions":{"target":"ES2019","module":"none","outFile":"dist/app.js","strict":False,"skipLibCheck":True,"lib":["DOM","ES2019"]},"files":files}
(root/"tsconfig.json").write_text(json.dumps(cfg,indent=2),encoding="utf-8")
print(f"tsconfig: {len(files)} source files")
