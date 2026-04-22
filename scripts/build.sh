#!/usr/bin/env bash
# build.sh — programming-tutor skill packager
#
# Packages the skill source files into a `.skill` archive (zip) that can be
# installed into Claude Code or Cowork.
#
# Usage:
#   bash scripts/build.sh              # produces dist/programming-tutor.skill
#   bash scripts/build.sh custom-name  # produces dist/custom-name.skill
#
# The resulting archive contains SKILL.md and everything under references/,
# assets/, scripts/, plus README.md and LICENSE. It excludes the .git
# directory, the dist/ directory itself, any existing .skill archives,
# .DS_Store, editor temp files, and the progress/plan files learners may
# create.

set -euo pipefail

# Resolve the repo root (scripts/ is always directly under it)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"

ARTIFACT_NAME="${1:-programming-tutor}"
DIST_DIR="$ROOT_DIR/dist"
OUTPUT="$DIST_DIR/${ARTIFACT_NAME}.skill"

mkdir -p "$DIST_DIR"
rm -f "$OUTPUT"

cd "$ROOT_DIR"

# Prefer zip(1); fall back to python's zipfile if zip isn't available.
if command -v zip >/dev/null 2>&1; then
  zip -r "$OUTPUT" . \
    -x ".git/*" \
    -x ".github/*" \
    -x "dist/*" \
    -x "*.skill" \
    -x "*.DS_Store" \
    -x "*.swp" \
    -x "*.swo" \
    -x "*~" \
    -x "learning-plan.md" \
    -x "progress.md" \
    -x "__pycache__/*" \
    -x "*.pyc" \
    -x "*.log" >/dev/null
else
  python3 - "$OUTPUT" "$ROOT_DIR" <<'PY'
import os, sys, zipfile, fnmatch

out_path, root = sys.argv[1], sys.argv[2]
EXCLUDE_DIRS = {".git", ".github", "dist", "__pycache__"}
EXCLUDE_FILES = [
    "*.skill", "*.DS_Store", "*.swp", "*.swo", "*~", "*.pyc", "*.log",
    "learning-plan.md", "progress.md",
]

def skip(name):
    return any(fnmatch.fnmatch(name, p) for p in EXCLUDE_FILES)

with zipfile.ZipFile(out_path, "w", zipfile.ZIP_DEFLATED) as z:
    for dirpath, dirnames, filenames in os.walk(root):
        dirnames[:] = [d for d in dirnames if d not in EXCLUDE_DIRS]
        for f in filenames:
            if skip(f):
                continue
            full = os.path.join(dirpath, f)
            arc = os.path.relpath(full, root)
            z.write(full, arc)
PY
fi

bytes="$(wc -c < "$OUTPUT" | tr -d ' ')"
echo "Built: $OUTPUT (${bytes} bytes)"
echo
echo "Install it:"
echo "  - Claude Code: double-click the file, or use 'Install Skill' in the UI"
echo "  - Cowork: drag the file into the chat, then click 'Save Skill'"
