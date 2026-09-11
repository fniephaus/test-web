---
layout: toc_content_ecosystem
title: Frequently Asked Questions
link_title: FAQs
toc_group: community
permalink: "/faq/"
---

<h1>Frequently Asked Questions</h1>

### How is GraalVM Licensed?

Oracle GraalVM is licensed under [GraalVM Free Terms and Conditions (GFTC) including License for Early Adopter Versions](https://www.oracle.com/downloads/licenses/graal-free-license.html).
Subject to the conditions in the license, including the License for Early Adopter Versions, the GFTC is intended to permit use by any user including commercial and production use.
Redistribution is permitted as long as it is not for a fee.
Oracle GraalVM versions prior to 25 (including JDK 17 and JDK 21) are supported on Oracle Cloud Infrastructure.

GraalVM Community Edition is distributed under [version 2 of the GNU General Public License with the “Classpath” Exception](https://github.com/oracle/graal/blob/master/LICENSE).
We also recommend checking the [licenses](https://github.com/oracle/graal#license) of the individual GraalVM components (which are generally derivative of the license of a particular language).

### What is the "GraalVM Free Terms and Conditions (GFTC) including License for Early Adopter Versions" License?

The [GFTC](https://www.oracle.com/downloads/licenses/graal-free-license.html) is the license for GraalVM for JDK 21, and later releases. Subject to the conditions of the license, it permits free use for all users – even commercial and production use. There is no click through license so automating downloads of it has never been easier.

### What are the restrictions on the "GFTC"?

The [GFTC](https://www.oracle.com/downloads/licenses/graal-free-license.html) is intended to permit use of the Program, including runtime image output produced by the jlink tool or GraalVM Native Image feature, by any user, including in commercial and production use. Hosted use, including allowing use by third parties who do not obtain a copy of the Program or runtime images, is generally considered use for your internal business operations, and you may charge fees for your service. Redistribution is permitted as long as it is not for a fee.

### Where Should I Report Bugs, Security Issues, or Enhancement Requests?

Please report any bugs or enhancement requests for GraalVM Community Edition using [GitHub Issues](https://github.com/oracle/graal/issues).
Report Oracle GraalVM bugs or enhancement requests via [My Oracle Support](https://support.oracle.com).

Any security vulnerabilities in either Oracle GraalVM or GraalVM Community should _only_ be reported via email to [secalert_us@oracle.com](mailto:secalert_us@oracle.com).
Please consult our [Reporting Vulnerabilities guide](https://www.oracle.com/corporate/security-practices/assurance/vulnerability/reporting.html) for more information on reporting security vulnerabilities.
Do **not** use GitHub Issues to report security issues.

### How do I Contribute to GraalVM?

We welcome contributions to GraalVM from the community and are thankful for past contributions both big and small.
There are two common ways to contribute:
- By submitting [GitHub issues](https://github.com/oracle/graal/issues) for bug reports, questions, or requests for enhancements.
- By creating [GitHub pull requests](https://github.com/oracle/graal/pulls).

See [how to become a GraalVM contributor](../community/contributors.md).
If you wish to contribute to the documentation, please check [this guide](https://github.com/oracle/graal/blob/master/docs/README.md).

### How Can I Receive Updates about GraalVM?

We maintain three mailing lists:

* _graalvm-announce@oss.oracle.com_ -- a low traffic announcement list used by the project maintainers;
* _graalvm-users@oss.oracle.com_ -- an open source user mailing list for general questions and discussions;
* _graalvm-dev@oss.oracle.com_ -- a list for contributors and language implementors.

Additional ways to stay up-to-date with GraalVM development include following GraalVM on the [Medium blogging platform](https://medium.com/graalvm), following the _@graalvm_ X handle, following GraalVM on [Bluesky](https://bsky.app/profile/graalvm.org) and [LinkedIn](https://www.linkedin.com/company/graalvm/), or watching the [github.com/oracle/graal](https://github.com/oracle/graal) repository.

### What Are the Available Distributions of GraalVM?

GraalVM is available as **Oracle GraalVM** and **GraalVM Community Edition**.
Oracle GraalVM is based on Oracle JDK, whereas GraalVM Community Edition is based on OpenJDK.
You can download Oracle GraalVM and GraalVM Community Edition from [graalvm.org/downloads](https://www.graalvm.org/downloads/){:target="_blank"}.

There are also downstream distributions of GraalVM Community Edition from:
- Bellsoft [Liberica Native Image Kit](https://bell-sw.com/liberica-native-image-kit/){:target="_blank"}
- RedHat [Mandrel](https://github.com/graalvm/mandrel){:target="_blank"}

### Which Microservice Frameworks Employ GraalVM Native Image?

Several Java microservice frameworks are certified on [GraalVM Native Image](../../docs/reference-manual/native-image/README.md).
Examples include: [Micronaut](https://micronaut.io), [Spring](https://spring.io/), and [Quarkus](https://quarkus.io).
For these frameworks Native Image significantly reduces the startup time and runtime memory requirements.

See [Frameworks Ready for Native Image](https://www.graalvm.org/native-image/libraries-and-frameworks/).

### Are There Existing Real-World Production Deployments of GraalVM?

Several production deployments of GraalVM exist today.
See [GraalVM Use Cases](https://www.graalvm.org/use-cases/).

We thank early adopters of our technology who give us feedback on the project and help us develop new features.
