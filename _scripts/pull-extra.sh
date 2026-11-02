#!/usr/bin/env bash
set -euo pipefail

readonly SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
readonly SITE_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"
readonly REPOS_DIR="$SITE_DIR/repos"
graal_ref="${1:?Usage: $0 <graal-release-ref> <truffleruby-tag>}"
truffleruby_ref="${2:?Usage: $0 <graal-release-ref> <truffleruby-tag>}"

mkdir -p "$REPOS_DIR"
rm -rf "$SITE_DIR/docs" "$SITE_DIR/truffle/docs"

checkout_repo() {
  local name="$1"
  local ref="$2"
  shift 2
  local directory="$REPOS_DIR/$name"
  local repository="https://github.com/oracle/$name.git"

  if [[ ! -d "$directory/.git" ]]; then
    git clone --depth 1 --filter=blob:none --no-checkout "$repository" "$directory"
  else
    git -C "$directory" remote set-url origin "$repository"
  fi

  git -C "$directory" sparse-checkout init --cone
  git -C "$directory" sparse-checkout set "$@"
  git -C "$directory" fetch --depth 1 --filter=blob:none origin "$ref"
  git -C "$directory" checkout --detach --force FETCH_HEAD
}

copy_docs() {
  local source="$1"
  local target="$2"
  if [[ ! -d "$source" ]]; then
    echo "Required documentation directory is missing: $source" >&2
    exit 1
  fi
  mkdir -p "$target"
  cp -pRL "$source"/. "$target"/
}

# Core and Truffle docs are in Graal; the languages remain in their public repos.
checkout_repo graal "$graal_ref" docs truffle/docs
copy_docs "$REPOS_DIR/graal/docs" "$SITE_DIR/docs"
copy_docs "$REPOS_DIR/graal/truffle/docs" "$SITE_DIR/truffle/docs"

checkout_repo graaljs "$graal_ref" docs/user
copy_docs "$REPOS_DIR/graaljs/docs/user" "$SITE_DIR/docs/reference-manual/js"

checkout_repo graalpython "$graal_ref" docs/user
copy_docs "$REPOS_DIR/graalpython/docs/user" "$SITE_DIR/docs/reference-manual/python"

checkout_repo fastr "$graal_ref" documentation/user
copy_docs "$REPOS_DIR/fastr/documentation/user" "$SITE_DIR/docs/reference-manual/r"

# TruffleRuby publishes vm-* release tags rather than GraalVM release branches.
# Cone-mode sparse checkout includes root files such as README.md.
checkout_repo truffleruby "$truffleruby_ref" doc tool
ruby "$REPOS_DIR/truffleruby/tool/generate-user-doc.rb"
copy_docs "$REPOS_DIR/truffleruby/doc/user" "$SITE_DIR/docs/reference-manual/ruby"

# Rewrite source-relative links against the assembled website tree.
for directory in "$SITE_DIR/docs" "$SITE_DIR/truffle/docs"; do
  while IFS= read -r -d '' file; do
    ruby "$SCRIPT_DIR/absolutize.rb" "$file"
  done < <(find "$directory" -type f -name '*.md' -print0)
done
