# GraalVM Website

This repository contains the sources for the [GraalVM website](https://www.graalvm.org/): layouts, includes, styles, static pages, redirects, public release notes, images, and the scripts that assemble the site.

The GraalVM documentation rendered by the website is not duplicated here.
During a build, it is pulled from the Graal repository's release branches such as `release/graal-vm/25.4` and `release/graal-vm/25.0`, or from `master` for the development documentation version.

The `jekyll-build` branch is the source branch for website changes.
The `master` branch contains generated site output and is updated by the publishing workflow.
The Javadoc publishing workflow builds the versioned Javadocs with the matching public Graal release branch and the `mx` revision declared by that branch, then updates the corresponding directories in `master`.

## Build the site

Install Ruby, Bundler, Git, and `rsync`, then run:

```bash
bundle install
./_scripts/build-website.sh
```

The generated site is written to `_site/`, which is ignored by Git.

For a shorter local build of the current and JDK 25 documentation, run:

```bash
./_scripts/build-website-dev.sh
bundle exec jekyll serve --source _site
```

## Contributing

Make product-documentation changes in [oracle/graal](https://github.com/oracle/graal).
This repository supplies website-specific navigation, layouts, redirects, and presentation around that documentation.

See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidance.

## License

The source is licensed under the [Universal Permissive License 1.0](LICENSE).
