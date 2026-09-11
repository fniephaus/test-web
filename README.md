# GraalVM Website

This repository contains the sources for the [GraalVM website](https://www.graalvm.org/): layouts, includes, styles, static pages, redirects, public release notes, images, and the scripts that assemble the site.

The GraalVM documentation rendered by the website is not duplicated here.
During a build, it is pulled from the public [oracle/graal](https://github.com/oracle/graal) repository at pinned release tags, or from `master` for development documentation version.

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
