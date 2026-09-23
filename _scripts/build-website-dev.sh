#!/bin/bash
set -ex
export JEKYLL_ENV=development

# bundle config --local path vendor/bundle
# bundle install

restore_dir=$(mktemp -d)
rsync -a pages/redirects/ "$restore_dir/pages-redirects/"
cp pages/ruby/ruby.md "$restore_dir/ruby.md"

cleanup() {
  rm -rf pages/redirects
  mkdir -p pages/redirects
  rsync -a "$restore_dir/pages-redirects/" pages/redirects/
  cp "$restore_dir/ruby.md" pages/ruby/ruby.md
  rm -rf "$restore_dir"
}

trap cleanup EXIT

# index.md is the public website home page.

# Build non-versioned site and the redirects for non-versioned URLs.
./_scripts/pull-extra.sh docs/graal-vm/25.4
ruby _scripts/process_front_matter.rb --add-title pages release-notes
ruby _scripts/process_front_matter.rb --add-title --add-version-to-permalinks --add-versioned-redirects docs truffle/docs espresso/docs web-image/docs pages/redirects
bundle exec jekyll build --config _configs/config_community_latest.yml

# Build JDK 25.0 documentation
./_scripts/pull-extra.sh docs/graal-vm/25.0
ruby _scripts/process_front_matter.rb --add-title pages release-notes
ruby _scripts/process_front_matter.rb --add-title --add-version-to-permalinks --add-versioned-redirects docs truffle/docs espresso/docs web-image/docs pages/redirects
bundle exec jekyll build --destination jdk25 --config _configs/config_community_jdk25.yml
rsync -av jdk25/jdk25 _site/
rsync -av --exclude "*.html" jdk25/docs _site/ # copy additional resources
rm -rf jdk25

# Use ./_scripts/serve.sh to serve the website without rebuilding
