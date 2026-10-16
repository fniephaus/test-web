#!/bin/bash
set -ex
export JEKYLL_ENV=production

cp pages/native-image/libraries-and-frameworks-with-header.md pages/native-image/libraries-and-frameworks.md

# Build LATEST version documentation from the current development branch.
# Build non-versioned site and the redirects for non-versioned URLs.
./_scripts/pull-extra.sh release/graal-vm/25.4
ruby _scripts/process_front_matter.rb --add-title pages release-notes
ruby _scripts/process_front_matter.rb --add-title --add-version-to-permalinks --add-versioned-redirects docs truffle/docs espresso/docs web-image/docs pages/redirects
bundle exec jekyll build --config _configs/config_community_latest.yml

# Build JDK 25.4 documentation
./_scripts/pull-extra.sh release/graal-vm/25.4
ruby _scripts/process_front_matter.rb --add-title pages release-notes
ruby _scripts/process_front_matter.rb --add-title --add-version-to-permalinks --add-versioned-redirects docs truffle/docs espresso/docs web-image/docs pages/redirects
bundle exec jekyll build --destination jdk25.4 --config _configs/config_community_jdk25i.yml
./_scripts/merge_sitemaps.rb _site/sitemap.xml jdk25.4/sitemap.xml https://www.graalvm.org/jdk25.4/
rsync -av jdk25.4/jdk25.4 _site/
rsync -av --exclude "*.html" jdk25.4/docs _site/
rm -rf jdk25.4

# Build JDK 25.0 documentation
./_scripts/pull-extra.sh release/graal-vm/25.0
# JDK 25 docs use the same source tree as latest, so rebuild the processed front matter.
ruby _scripts/process_front_matter.rb --add-title pages release-notes
ruby _scripts/process_front_matter.rb --add-title --add-version-to-permalinks --add-versioned-redirects docs truffle/docs espresso/docs web-image/docs pages/redirects
bundle exec jekyll build --destination jdk25 --config _configs/config_community_jdk25.yml
./_scripts/merge_sitemaps.rb _site/sitemap.xml jdk25/sitemap.xml https://www.graalvm.org/jdk25/
rsync -av jdk25/jdk25 _site/
rsync -av --exclude "*.html" jdk25/docs _site/
rm -rf jdk25

# Build JDK 21 documentation
./_scripts/pull-extra.sh release/graal-vm/23.1
ruby _scripts/process_front_matter.rb --add-title pages release-notes
ruby _scripts/process_front_matter.rb --add-title --add-latest-canonical-url --add-version-to-permalinks docs truffle/docs pages/redirects
bundle exec jekyll build --destination jdk21 --config _configs/config_community_jdk21.yml
./_scripts/merge_sitemaps.rb _site/sitemap.xml jdk21/sitemap.xml https://www.graalvm.org/jdk21/
rsync -av jdk21/jdk21 _site/
rsync -av --exclude "*.html" jdk21/docs _site/
rm -rf jdk21

# Build JDK 17 documentation
./_scripts/pull-extra.sh release/graal-vm/23.0
ruby _scripts/process_front_matter.rb --add-title pages release-notes
ruby _scripts/process_front_matter.rb --add-title --add-latest-canonical-url --add-version-to-permalinks docs truffle/docs pages/redirects
bundle exec jekyll build --destination jdk17 --config _configs/config_community_jdk17.yml
./_scripts/merge_sitemaps.rb _site/sitemap.xml jdk17/sitemap.xml https://www.graalvm.org/jdk17/
rsync -av jdk17/jdk17 _site/
rsync -av --exclude "*.html" jdk17/docs _site/
rm -rf jdk17

# Apply the experimental docs layout for the JDK 17 site.
cp _layouts/docs-experimental.html _layouts/docs.html

# Restore the original layouts
git checkout _layouts/docs.html

# Build DEV documentation (always from master)
./_scripts/pull-extra.sh master
ruby _scripts/process_front_matter.rb --add-title --add-version-to-permalinks docs truffle/docs espresso/docs web-image/docs pages/redirects
bundle exec jekyll build --destination dev --config _configs/config_community_dev.yml
./_scripts/merge_sitemaps.rb _site/sitemap.xml dev/sitemap.xml https://www.graalvm.org/dev/
rsync -av dev/dev _site/
rsync -av --exclude "*.html" dev/docs _site/
rm -rf dev

# Restore source pages that process_front_matter.rb mutates while generating
# versioned redirects and canonical URLs.
git checkout -- \
  pages/redirects/fastr.md \
  pages/redirects/graaljs.md \
  pages/redirects/graalpy.md \
  pages/redirects/graalwasm.md \
  pages/redirects/truffleruby.md \
  pages/ruby/ruby.md

echo "Website build completed successfully: _site/index.html"
