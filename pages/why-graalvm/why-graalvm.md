---
layout: toc_content_ecosystem
link_title: Why GraalVM?
permalink: "/why-graalvm/"
redirect_from: "/docs/why-graal/"
toc_group: community
title: Why GraalVM?
---

# Why GraalVM?

GraalVM compiles your Java applications ahead of time into standalone binaries that start instantly, provide peak performance with no warmup, and use fewer resources.

The key GraalVM benefits are:

* **Low Resource Usage**: Java applications compiled ahead-of-time by GraalVM require less memory and CPU to run. No memory or CPU cycles are spent on just-in-time compilation. As a result, your applications need fewer resources to run and are cheaper to operate at scale.
* **Fast Startup**: With GraalVM, you can start your Java application faster by initializing some of its elements at build time instead of run time, and instantly achieve predictable peak performance with no warmup.
* **Compact Packaging**: Java applications compiled ahead-of-time by GraalVM are small and can be easily packaged into lightweight container images for fast and efficient deployment.
* **Improved Security**: GraalVM reduces the attack surface of your Java application by excluding the following from the binary: unreachable code (unused classes, methods, and fields), the just-in-time compilation infrastructure, and build-time initialized code.
GraalVM's closed world assumption prevents your application from loading unknown code by disabling dynamic features such as reflection, serialization, and so on at run time, and requires an explicit include list of such classes, methods, and fields at build time.
GraalVM can embed a software bill of materials (SBOM) in your binary making it easier for you to use common security scanners to check your Java application binaries for published CVEs (Common Vulnerabilities and Exposures).
* **Easily Build Cloud Native Microservices**: Popular microservices frameworks such as Spring Boot, Micronaut, Helidon, and Quarkus, and cloud platforms such as Oracle Cloud Infrastructure (OCI), Amazon Web Services (AWS), Google Cloud Platform (GCP), and Microsoft Azure all support GraalVM.
This makes it easy for you to build cloud native Java microservices, compiled as binaries, packaged in small containers, and run on cloud platforms - OCI, AWS, GCP and Azure.
* **Extend your Java Application with Python and Other Languages**: With GraalVM you can embed languages such as Python, JavaScript, and others to extend your Java application.
* **Use Existing Development and Monitoring Tools**: Your existing Java application development and monitoring tools work with GraalVM application binaries.
GraalVM provides build plugins for Maven and Gradle, and GitHub Actions for CI/CD.
GraalVM supports Java Flight Recorder (JFR), Java Management Extensions (JMX), heap dumps, VisualVM, and other monitoring tools.
GraalVM works with existing Java editors/IDEs, and unit test frameworks such as JUnit.

## Run Java Faster on GraalVM JDK

GraalVM is a full-scale JDK distribution that can make Java applications run faster with a new advanced just-in-time compiler (Graal). As a platform it uses the Java HotSpot VM, so all tools and libraries that work on OpenJDK, work the same way on GraalVM JDK. In this context, GraalVM replaces the last-tier optimizing compiler in the JVM (C2) with the Graal compiler. This compiler is the outcome of 10+ years of research at Oracle Labs and includes several new optimizations, such as [advanced inlining](https://dl.acm.org/doi/10.5555/3314872.3314893), [partial escape analysis](http://www.ssw.uni-linz.ac.at/Research/Papers/Stadler14/Stadler2014-CGO-PEA.pdf), [code duplication](https://dl.acm.org/doi/10.1145/3168811), and [speculative optimizations](https://dl.acm.org/doi/10.1145/2647508.2647521). GraalVM is itself written in Java, rather than C/C++, which simplifies maintenance and helps us develop and deliver new optimizations much faster.

Several companies, such as [Oracle Cloud](https://blogs.oracle.com/cloud-infrastructure/post/graalvm-powers-oracle-cloud-infrastructure), [Twitter](https://www.youtube.com/watch?v=ZbccuoaLChk), and [Facebook](https://medium.com/graalvm/graalvm-at-facebook-af09338ac519) are running large-scale Java applications on GraalVM JDK to increase performance, reduce resource usage, and lower deployment costs.
GraalVM JDK can simply be used as a drop-in replacement for other JDKs — [see how to get started](https://www.graalvm.org/latest/docs/getting-started/).

## Build Native Executables of Java Applications

Running applications on the JVM can come with startup and footprint costs.
GraalVM includes Native Image: a technology which leverages the Graal compiler to produce native executables of Java applications, that are self-contained and thus no longer require the JVM.
The image generation process employs static analysis to find all code reachable from the main Java method and then performs full ahead-of-time (AOT) compilation.
At build time, it also performs snapshotting, so, at run time, the application starts much faster with pre-populated heap.
The resulting native binary contains the whole program in machine code form that is ready for execution instantly at startup.
Such native executables have the following features:
* Instant startup due to pre-initializing the JDK and user code at build time
* Reduced memory and CPU usage due to minimized code execution overhead
* Small packaging due to the AOT approach and slim runtime components
* Reduced attack surface due to code elimination and the AOT approach

Give Native Image a try by [building your first application](https://www.graalvm.org/latest/reference-manual/native-image/).

## Work with Latest Industry Tools and Platforms

Native Image is a great deployment model for microservices and serverless Java applications. This is the reason why several major application frameworks, such as [Spring Boot](https://docs.spring.io/spring-boot/docs/3.0.0/reference/htmlsingle/#native-image), [Micronaut](https://docs.micronaut.io/latest/guide/index.html#graal), [Quarkus](https://quarkus.io/guides/building-native-image#producing-a-native-executable), and [Helidon](https://helidon.io/docs/v3/#/se/guides/graalnative), offer Native Image support. There is an entire ecosystem of libraries, frameworks, and tools that you can use with Native Image out of the box — [view the list here](https://www.graalvm.org/native-image/libraries-and-frameworks/).

All major cloud platforms also offer support for building applications with GraalVM Native Image. You can easily build applications with GraalVM on [Oracle Cloud Infrastructure](https://docs.oracle.com/en/learn/accelerate-applications-in-oci-with-graalvm-enterprise/index.html) (and get access to Oracle GraalVM as a part of your subscription), leverage GraalVM support in [Azure SDK for Java and Spring Cloud Azure](https://devblogs.microsoft.com/azure-sdk/announcing-graalvm-support-in-azure-sdk-for-java-and-spring-cloud-azure-libraries/), use Native Image in the [AWS SDK for Java](https://aws.amazon.com/blogs/developer/graalvm-native-image-support-in-the-aws-sdk-for-java-2-x/), and compile applications as native executables using Google Cloud's [Client Libraries for Java](https://cloud.google.com/java/docs/compile-native-images).

As an example of how GraalVM can improve cloud Java deployments, take a look at [Disney Streaming's use case](https://aws.amazon.com/blogs/opensource/improving-developer-productivity-at-disney-with-serverless-and-open-source/). While researching ways to mitigate the cold starts of their serverless Java workloads, they discovered that a function that took 3.6s to start on the JVM, started in under 100ms when compiled with GraalVM Native Image — so 36x faster! Even operating within minimal memory, such as 512 MB, a natively compiled application was still fully functional and started much faster than on the JVM.

## Extend Java with JavaScript, Python, and Other Languages

With GraalVM you can run JavaScript, Python, WebAssembly, and other languages, in the context of Java applications. It offers the ability to expose Java data structures to those languages with fine-grained host access filters. To get started, see how you can [build your first polyglot Java application](https://www.graalvm.org/latest/reference-manual/embed-languages/#compile-and-run-a-polyglot-application), [define guest language functions as Java values](https://www.graalvm.org/latest/reference-manual/embed-languages/#define-guest-language-functions-as-java-values), and [access guest languages from Java](https://www.graalvm.org/latest/reference-manual/embed-languages/#access-guest-languages-directly-from-java).

You can also use GraalVM and the [Truffle framework](https://www.graalvm.org/latest/graalvm-as-a-platform/language-implementation-framework/) as a platform for your languages and tools.
It will automatically derive high-performance code from your language interpreter and provide access to the rich tooling ecosystem.
Find out how to implement [your own language](https://www.graalvm.org/latest/graalvm-as-a-platform/implement-language/) or [tool](https://www.graalvm.org/latest/graalvm-as-a-platform/implement-instrument/).