#!/bin/bash
set -ex
export JEKYLL_ENV=development
## Run this script to test Native Image Libraries and Frameworks page only.

# Add a template file with header
cp pages/native-image/libraries-and-frameworks-with-header.md pages/native-image/libraries-and-frameworks.md

# Clone Reachability Metadata
git clone --depth 1 https://github.com/oracle/graalvm-reachability-metadata.git _graalvm-reachability-metadata
# Fetch JSON schema, create the native-image-tested-libraries-and-frameworks.html layout, and include it into ni-libraries-and-frameworks.html
ruby _scripts/generate-library-and-framework-list.rb

# Process docs headers
ruby _scripts/process_front_matter.rb --add-title pages release-notes
ruby _scripts/process_front_matter.rb --add-title --add-version-to-permalinks --add-versioned-redirects docs truffle/docs espresso/docs web-image/docs

# Build LATEST and nonversioned site and serve locally
bundle exec jekyll serve --config _configs/config_community_latest.yml

# Checkout original file
git checkout pages/native-image/libraries-and-frameworks.md

# The page will be accessible at http://localhost:4000/native-image/libraries-and-frameworks/
