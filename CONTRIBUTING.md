# Contributing to the GraalVM Website

Thank you for improving the GraalVM website.

Where to make a change:

- Product documentation belongs in [oracle/graal](https://github.com/oracle/graal). Follow the [GraalVM documentation guide](https://github.com/oracle/graal/blob/master/docs/README.md) for documentation structure, terminology, and Markdown conventions.
- Website navigation, layouts, styles, static pages, redirects, release notes, and approved static assets belong in this repository.
- Base website changes on the `jekyll-build` branch. The `master` branch contains generated website output and is maintained by GitHub Actions.
- Do not edit generated Javadoc directories in `master` manually. The Javadoc workflow rebuilds them from the matching public Graal release branches.

## Before opening a pull request

1. Keep the change focused and explain its user-facing effect.
2. Run the relevant local build:

   ```bash
   bundle install
   ./_scripts/build-website-dev.sh
   ```

3. Verify changed links, redirects, and rendered pages in `_site/`.
4. Include only assets with an identified owner and approved redistribution terms. Preserve applicable copyright and license notices.
5. State the validation performed in the pull request description.

## Pull requests

Use the repository issue tracker for reproducible bugs and actionable enhancement requests. Pull requests should describe their motivation, affected pages, and validation.

Contributions accepted into this project require the [Oracle Contributor Agreement](https://oca.opensource.oracle.com/). By submitting a contribution, you confirm that you have the right to contribute all submitted material, including documentation, images, and other assets.
