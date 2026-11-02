# Archived GraalVM documentation

This directory contains the Jekyll site configuration and historical navigation
used to build documentation for inactive GraalVM releases. Product documentation
is fetched from the public GraalVM component repositories during a build.

The archived site uses Ruby 3.4 and Jekyll 4.4, with its dependencies locked in
`Gemfile.lock`.

## Build locally

From this directory, install dependencies and build one archived version:

```bash
bundle install
bash _scripts/build.sh <version>
```

The build script validates the requested version and writes the generated site
to a directory with the same name.

## Build and publish with GitHub Actions

In GitHub Actions, open **Build archived docs**, click **Run workflow**, and
enter the desired version in the **version** field. The build script validates
it, and the workflow builds and checks only that version. Enable **publish** on
a manual run from the default branch to update the selected directory on
`gh-pages`.
