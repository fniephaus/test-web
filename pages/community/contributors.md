---
layout: toc_content_ecosystem
link_title: Contributors
permalink: "/community/contributors/"
toc_group: community
title: For Contributors
---
# For Contributors

GraalVM is an open source Oracle project where people from all over the world contribute their work, help each other, and make GraalVM innovative.
We are thankful for past contributions both big and small and always welcome new collaborators!
Only a large community can make this project a strong language virtualization technology.

There are two common ways to collaborate:
- By submitting [GitHub issues](https://github.com/oracle/graal/issues) for reproducible bugs and concrete feature requests.
- By creating [GitHub pull requests](https://github.com/oracle/graal/pulls) for code, tests, documentation, and other improvements.

## Contributing to GraalVM Source

If you would like to contribute to the GraalVM source or one of its sub-projects hosted in the [Oracle organization on GitHub](https://github.com/oracle), the typical process has three stages:

1. Create a pull request. [Fork the repository](https://github.com/oracle/graal), prepare your change, and open a pull request with a clear explanation of what changed, why it changed, and how it was validated.
2. Sign the [Oracle Contributor Agreement (OCA)](https://oca.opensource.oracle.com/). Contributions accepted into the project must be covered by the OCA.
3. Go through review and merge. Maintainers review the proposed change, may request follow-up changes or clarification, and merge it once it is ready.

If there is a delay in showing you have signed OCA, or the bot leaves a message on your pull request that you have not signed the OCA, leave a comment on the pull request stating that you are now covered by the OCA. Alternatively, send an email to [oracle-ca_us@oracle.com](mailto:oracle-ca_us@oracle.com).

Pull requests should clearly explain what changed, why it changed, and how it was validated.
For a detailed description of contributor expectations, including testing, documentation, licensing, and review responsibilities, see [CONTRIBUTING.md](https://github.com/oracle/graal/blob/master/CONTRIBUTING.md).

## AI-Assisted Contributions

GraalVM accepts AI-assisted contributions.
Use of AI assistance does not change the standard contribution process.
The human contributor remains responsible for the entire submission, including any AI-assisted portion.
Contributors are expected to review and understand what they submit, verify that it is correct and necessary, address reviewer questions themselves, and stand behind the change during review and maintenance.

The [Oracle Contributor Agreement (OCA)](https://oca.opensource.oracle.com/) and all normal contribution requirements apply to AI-assisted and non-AI-assisted contributions alike.

For the full policy on AI-assisted contributions, see [CODING_ASSISTANTS.md](https://github.com/oracle/graal/blob/master/CODING_ASSISTANTS.md). For the main contribution process, see [CONTRIBUTING.md](https://github.com/oracle/graal/blob/master/CONTRIBUTING.md).

## Development Environment

If you consider contributing to the GraalVM core, start by learning how to build a GraalVM distribution from source: [Building GraalVM from Source](https://github.com/oracle/graal/blob/master/vm/README.md).

If you consider contributing solely to the documentation, check [this guide](https://github.com/oracle/graal/blob/master/docs/README.md).

Learn how to set up a proper development environment, load the GraalVM project into the IDE, and see the main classes one could look at to have the basic understanding what the compiler is doing. This video demonstrates the above.

<div class="contributors-video-block">
  <div class="row">
    <div class="col-sm-12">
      <div class="vlog__video">
        <img src='{{ "/resources/img/videos/building_graalvm_session.png" | relative_url }}' alt="build GraalVM from sources">
            <a href="#" data-video="3Gh0cz3vjG8" class="btn btn-primary btn-primary--filled js-popup">watch video</a>
      </div>
    </div>
  </div>
</div>

  <div id="video-view" class="modal-window">
    <div class="modal-window__content">
      <button type="button" title="Close" id="js-close" class="modal-window__close"><img src='{{ "/resources/img/btn-close.svg" | relative_url }}' alt="close_video"></button>
      <div class="modal-window__video">
        <div id="player"></div>
      </div>
    </div>
  </div>

## Reporting Bugs, Feature Requests, and Questions

- Open a [GitHub issue](https://github.com/oracle/graal/issues) for reproducible bugs and concrete feature requests.
- Use [GitHub Discussions](https://github.com/oracle/graal/discussions) for questions related to working with the sources or extending the GraalVM ecosystem by creating new languages, tools, or embeddings.
- Join the [GraalVM Slack community](slack-invitation.md) for community support and discussion.
- Do not report security vulnerabilities in public issue trackers. Follow the instructions in [SECURITY.md](https://github.com/oracle/graal/blob/master/SECURITY.md).

## Code of Conduct

GraalVM and its related projects are hosted in the Oracle organization on GitHub, and contributors are expected to abide by the [Contributor Covenant Code of Conduct](conduct.md).

For additional guidance and the current contribution policy, see [CONTRIBUTING.md](https://github.com/oracle/graal/blob/master/CONTRIBUTING.md) and [CODING_ASSISTANTS.md](https://github.com/oracle/graal/blob/master/CODING_ASSISTANTS.md).
