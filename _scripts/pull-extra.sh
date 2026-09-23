#!/usr/bin/env bash
# Pull the GraalVM documentation used to build this site.
set -euo pipefail

readonly GRAAL_REPOSITORY="${GRAAL_REPOSITORY:-ssh://git@ol-bitbucket-mirror1.oraclecorp.com:7999/g/graal.git}"
readonly GRAAL_CHECKOUT="${GRAAL_CHECKOUT:-$PWD/repos/graal}"
graal_branch="${1:?Usage: $0 <graal-branch>}"

copy_docs() {
  local source="$1"
  local target="$2"
  [[ -d "$source" ]] || return 0
  mkdir -p "$target"
  cp -pRL "$source"/. "$target"/
}

# These directories are generated build inputs and must never become website source.
rm -rf docs truffle/docs espresso/docs web-image/docs

mkdir -p "$(dirname "$GRAAL_CHECKOUT")"

if [[ ! -d "$GRAAL_CHECKOUT/.git" ]]; then
  git clone --no-checkout "$GRAAL_REPOSITORY" "$GRAAL_CHECKOUT"
elif git -C "$GRAAL_CHECKOUT" remote get-url origin >/dev/null 2>&1; then
  git -C "$GRAAL_CHECKOUT" remote set-url origin "$GRAAL_REPOSITORY"
else
  git -C "$GRAAL_CHECKOUT" remote add origin "$GRAAL_REPOSITORY"
fi

git -C "$GRAAL_CHECKOUT" fetch --depth 1 origin "$graal_branch"
git -C "$GRAAL_CHECKOUT" checkout --detach --force FETCH_HEAD

copy_docs "$GRAAL_CHECKOUT/docs" docs
copy_docs "$GRAAL_CHECKOUT/truffle/docs" truffle/docs
copy_docs "$GRAAL_CHECKOUT/espresso/docs" espresso/docs
copy_docs "$GRAAL_CHECKOUT/web-image/docs" web-image/docs

# Native Image skill assets are source material for tooling, not website pages.
rm -rf docs/reference-manual/native-image/assets/skills

# The site-owned community page is the canonical Publications page.
rm -f docs/Publications.md

# The public site does not ship Oracle Help Center infrastructure. Exclude
# documentation pages that require its historical layout instead of rendering
# them without their required assets and navigation.
while IFS= read -r -d '' file; do
  if grep -qx 'layout: ohc' "$file"; then
    rm -f "$file"
  fi
done < <(find docs -name '*.md' -print0)

# Remove the corresponding navigation subsection from the public Getting
# Started page after its Oracle Help Center target has been excluded.
if [[ -f docs/getting-started/get-started.md ]]; then
  ruby -0pi -e 'sub(%r{\n### Oracle Cloud Infrastructure Users\n\nOracle Cloud Infrastructure users.*?Compute instance\.\n}m, "\n")' \
    docs/getting-started/get-started.md
fi

if [[ -f docs/reference-manual/embedding/embed-languages.md ]]; then
  ruby -0pi -e 'pattern = %r{tab(?<index>\d+)type="[^"]*"\s+tab\k<index>id="[^"]*"\s+tab\k<index>name="[^"]*"\s+tab\k<index>path="(?<path>[^"]*)"\s*}; $_ = $_.gsub(pattern) { |tab| match = Regexp.last_match; File.file?(File.join("_includes", match[:path])) ? tab : "" }' \
    docs/reference-manual/embedding/embed-languages.md
fi

for directory in docs truffle/docs espresso/docs web-image/docs; do
  [[ -d "$directory" ]] || continue
  while IFS= read -r -d '' file; do
    ruby _scripts/absolutize.rb "$file"
  done < <(find "$directory" -name '*.md' -print0)
done
