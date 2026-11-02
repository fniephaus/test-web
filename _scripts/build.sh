#!/usr/bin/env bash
set -euo pipefail

readonly SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly SITE_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"
version="${1:-${DOCS_VERSION:-}}"

case "$version" in
  21.3) graalvm_version=21.3; truffleruby_ref=vm-21.3.0 ;;
  22.0) graalvm_version=22.0; truffleruby_ref=vm-22.0.0.2 ;;
  22.1) graalvm_version=22.1; truffleruby_ref=vm-22.1.0 ;;
  22.2) graalvm_version=22.2; truffleruby_ref=vm-22.2.0 ;;
  22.3) graalvm_version=22.3; truffleruby_ref=vm-22.3.1 ;;
  jdk20) graalvm_version=23.0; truffleruby_ref=vm-23.0.1 ;;
  jdk22) graalvm_version=24.0; truffleruby_ref=vm-24.0.2 ;;
  jdk23) graalvm_version=24.1; truffleruby_ref=vm-24.1.2 ;;
  jdk24) graalvm_version=24.2; truffleruby_ref=vm-24.2.2 ;;
  *)
    echo "Unsupported archived docs version: $version" >&2
    echo "Choose one of: 21.3, 22.0, 22.1, 22.2, 22.3, jdk20, jdk22, jdk23, jdk24" >&2
    exit 2
    ;;
esac

export JEKYLL_ENV=production
cd "$SITE_DIR"

readonly temporary_dir="$(mktemp -d)"
cp _layouts/home.html "$temporary_dir/home.html"
if [[ -f _scripts/expected-output.txt ]]; then
  cp _scripts/expected-output.txt "$temporary_dir/expected-output.txt"
  expected_output_existed=true
else
  expected_output_existed=false
fi

restore_build_inputs() {
  cp "$temporary_dir/home.html" _layouts/home.html
  if [[ "$expected_output_existed" == true ]]; then
    cp "$temporary_dir/expected-output.txt" _scripts/expected-output.txt
  else
    rm -f _scripts/expected-output.txt
  fi
  rm -rf "$temporary_dir"
}
trap restore_build_inputs EXIT

# Each archived version has its own home page and expected output structure.
cp "_layouts/home-$version.html" _layouts/home.html
cp "_scripts/expected-output-$version.txt" _scripts/expected-output.txt

# The docs version and GraalVM release branch differ for JDK 20 and later.
bash ./_scripts/pull-extra.sh "release/graal-vm/$graalvm_version" "$truffleruby_ref"

rm -rf _site "$version"
bundle exec jekyll build --baseurl "/$version"
rm -f _site/sitemap.xml _site/robots.txt _site/redirects.json
cp -R _site "$version"

actual_output="$temporary_dir/actual-output.txt"
expected_output="$temporary_dir/sorted-expected-output.txt"
ls -1 "$version" | LC_ALL=C sort > "$actual_output"
LC_ALL=C sort _scripts/expected-output.txt > "$expected_output"
diff -u "$expected_output" "$actual_output"

echo "Archived docs build completed: $version/index.html"
