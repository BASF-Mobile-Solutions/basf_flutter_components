#!/usr/bin/env bash
set -euo pipefail

# Determine project root from script location:
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
LIB_DIR="$PROJECT_ROOT/lib"
OUT="$LIB_DIR/basf_flutter_components.dart"

# Sanity check:
if [ ! -d "$LIB_DIR" ]; then
  echo "Error: lib/ directory not found under project root ($PROJECT_ROOT)" >&2
  exit 1
fi

# Create a temp file next to the barrel:
TMP="$(mktemp "$LIB_DIR/.basf_exports.XXXXXX")"

# 1) Preserve or insert the library declaration:
if [ -f "$OUT" ] && head -n1 "$OUT" | grep -q '^library '; then
  head -n1 "$OUT" > "$TMP"
else
  echo "library basf_flutter_components;" > "$TMP"
fi

# 2) Add your manual package exports right after the library:
{
  echo ""
  echo "export 'package:flutter_bloc/flutter_bloc.dart';"
  echo "export 'package:hydrated_bloc/hydrated_bloc.dart';"
  echo "export 'package:path_provider/path_provider.dart';"
} >> "$TMP"

# 3) Generated warning header:
{
  echo ""
  echo "// GENERATED – do not edit by hand"
  echo ""
} >> "$TMP"

# 4) Append all exports, skipping the barrel itself, *.freezed.dart, *.g.dart, generated dirs:
find "$LIB_DIR" -type f -name '*.dart' \
  ! -path "$OUT" \
  ! -name '*.freezed.dart' \
  ! -name '*.g.dart' \
  ! -path "$LIB_DIR/.dart_tool/*" \
  ! -path "$LIB_DIR/generated/*" \
| sort \
| sed \
    -e "s|^$LIB_DIR/|export '|g" \
    -e "s|$|' ;|g" \
>> "$TMP"

# 5) Atomically replace the old barrel:
mv "$TMP" "$OUT"

echo "✅ Rebuilt $OUT with $(grep -c '^export' "$OUT") exports"
