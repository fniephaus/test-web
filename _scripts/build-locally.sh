#!/usr/bin/env bash
set -euo pipefail

readonly SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
version="${1:-jdk24}"

bash "$SCRIPT_DIR/build.sh" "$version"
echo "Built archived documentation: $SCRIPT_DIR/../$version/index.html"
