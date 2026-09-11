---
layout: full-width-layout
link_title: Advantages for Java
permalink: "/java/advantages/"
toc_group: java
title: Advantages for Java
---

<br>
<a href='{{ "/java/" | relative_url }}' class="link-back"><i>&#9664;</i>Back</a>

## Accelerating Java performance

GraalVM’s high-performance JIT compiler generates optimized native machine code that runs faster, produces less garbage, and uses less CPU thanks to a battery of advanced compiler optimizations and aggressive and sophisticated inlining techniques.
The end results are applications that run faster and consume fewer resources—reducing cloud and infrastructure costs.

<img src='{{ "/resources/img/java/20.3vs11.png" | relative_url }}' alt="Speedup vs JDK">

*Figure 1. Speedup vs OpenJDK 11*

The size of the speedup depends on the type of workload.
On the Renaissance benchmark suite, which “contains a range of modern workloads, comprising of various popular systems, frameworks and applications made for the JVM”, Oracle GraalVM achieves a geomean speedup of 1.55x over OpenJDK 8 and similar results for OpenJDK 11.

#### Oracle Cloud Infrastructure

By [running the Oracle Cloud Infrastructure (OCI) Monitoring (telemetry) service on Oracle GraalVM](https://blogs.oracle.com/cloud-infrastructure/graalvm-powers-oracle-cloud-infrastructure), a 10% transaction processing rate increase was achieved along with a 25% reduction in garbage collection times, a 17% reduction in GC pause times, and a 5% reduction CPU utilization.
These improvements have significant benefits for a memory intensive service that routinely processes tens of millions of data points, ingests billions of metrics, and serves millions of requests coming from an ever growing collection of OCI service offerings.

<img src='{{ "/resources/img/java/oci_monitoring.png" | relative_url }}' alt="OCI Monitoring Service Throughput">

*Figure 2. OCI Monitoring Service Throughput (transaction per second)*

<p style="text-align: -webkit-center;">
<a href='{{ "/docs/getting-started/" | relative_url }}' target="_blank" class="game-changer btn btn-primary">Quick start</a>
</p>

## Lower infrastructure costs

Higher application performance and lower CPU and memory usage are goals every developer strives for.
These goals are definitely laudable, and achieving them is easier with GraalVM, but the real value of these improvements is a reduction in the cost to run an application in production.
Faster applications with lower resource requirements translate into fewer servers required to deliver a given service, and fewer servers means lower monthly cloud bills and lower capital and operating costs for on premises deployments.

The math is straightforward.
Even with no reduction in resource requirements, with just a ~11% improvement in throughput, 9 servers can do what required 10 before.
That is one less cloud server to pay for or one less datacenter server to buy and maintain.

<blockquote>Oracle GraalVM was the performance choice for our Dell EMC Servers. Java workload analysis and SPECjbb®2015 benchmark improving max-jOPS results by almost 8%.</blockquote>

<p class="quote-author" style="text-align: -webkit-right;"><strong>— Kurtis Bowman, Director of Architecture, Server Office of the CTO, Dell EMC</strong></p>

#### Something to Tweet About

Twitter is one of the most popular social media services in the world running a platform used by millions of users around the globe daily.
To keep costs down and performance up, Twitter relies on GraalVM to run core services like Tweet, Social, and News. With the efficiency of the GraalVM JIT compiler, Twitter is able to meet their throughput targets with fewer servers, resulting in significant savings.

<blockquote>Being able to see 8–11 percent performance improvements on the same hardware without having to change the underlying code is a once-in-a-lifetime event, leading to substantial cost savings and future flexibility for Twitter.</blockquote>

<p class="quote-author" style="text-align: -webkit-right;"><strong>— Chris Thalinger, Staff Software Engineer, Twitter</strong></p>

<p style="text-align: -webkit-center;">
<a href='{{ "/docs/getting-started/" | relative_url }}' target="_blank" class="game-changer btn btn-primary">Quick start</a>
</p>

## Better performance with no code changes

While the OpenJDK project moves forward with the 6-month release cadence, which offers time-based release model where features get in whenever they are ready, a large part of the Java ecosystem is still using Java 8 and Java 11 in production.

GraalVM's dedication to improving the Java ecosystem comes with support for those major versions which are the most popular.
GraalVM includes a compatible JDK and currently offers downloads based on Java 8 or Java 11.
To use GraalVM to speed up Java applications, build native executables with the Native Image feature, or incorporate libraries from other languages, you do not have to undergo complex migrations to the latest OpenJDK release.
Migrating services to GraalVM mostly consists of replacing the JDK downloads or base container images with the GraalVM based ones without code changes or needing to leverage new language features!

<p style="text-align: -webkit-center;">
<a href='{{ "/docs/getting-started/" | relative_url }}' target="_blank" class="game-changer btn btn-primary">Quick start</a>
</p>

## Equally excellent developer productivity

One of the best features of GraalVM is its compatibility with all the tools in the Java ecosystem.
GraalVM can run Java applications offering better performance without code changes or any learning curve for developers.
GraalVM fits into your workflow, being a compatible JDK it not only runs the applications you are working on, but the Java tools that help you! GraalVM works in your debugger, works with your build tools, it works within your favourite IDE, you can migrate your continuous integration environment to it, run your issue tracker on it and all other Java services you are using.

You do not even have to be a Java developer! If other JVM languages are your cup of productivity, that is okay. From Kotlin, to Clojure, to Scala, GraalVM can help you run them all with excellent performance too.

GraalVM merges the power of the Java ecosystem and community with a more powerful JDK distribution for the best of all worlds.

<p style="text-align: -webkit-center;">
<a href='{{ "/tools/" | relative_url }}' target="_blank" class="game-changer btn btn-primary">Quick start</a>
</p>

## Supported by industry-leading Java application frameworks

Supported by industry-leading Java application frameworks, GraalVM is often cited as the most exciting innovation in the Java ecosystem.
For example, the ability to compile applications into native executables with the [Native Image technology](../../docs/reference-manual/native-image/README.md) revolutionises cloud deployments for Java applications.
It is especially important for microservices where individual services are either neatly packed in environments constrained by memory or quickly become a major part of the cloud cost.
Luckily, with GraalVM you do not have to rewrite your applications in Go to succeed in the cloud.
[Most major Java application and microservice frameworks are designed with GraalVM Native Image](https://blogs.oracle.com/javamagazine/java-frameworks-for-the-cloud-establishing-the-bounds-for-rapid-startups) in mind or are working on adding first-class support.

Micronaut, Helidon, Quarkus, or Spring Boot for microservices, PicoCLI for command line applications – whichever task you are facing, there's a GraalVM Native Image compatible framework available to make your job easier.

<p style="text-align: -webkit-center;">
<a href='{{ "/docs/getting-started/" | relative_url }}' target="_blank" class="game-changer btn btn-primary">Quick start</a>
</p>

## Expanding the Java ecosystem

The Java Virtual Machine (JVM) makes it possible to run Java programs on everything from small embedded devices to mainframes.
It is a high-performance runtime that abstracts away the details of underlying hardware and operating system platforms to enable code portability.
But it turns out the JVM does not actually know anything about the Java language itself as it executes programs compiled to the intermediate Java bytecode format.
This means that any language that can be compiled to Java bytecode can be run on the JVM, for example, Scala, Kotlin, and Clojure.
However, there are many popular languages that do not compile to Java bytecodes and cannot take advantage of the benefits provided by the JVM and the performance benefits of just-in-time compilation.

But thanks to the innovative [Truffle framework](../../truffle/docs/README.md), GraalVM does support the execution of a number of popular programming languages including JavaScript, Python, and WebAssembly on the JVM.
GraalVM and Truffle do not just make it possible to run non-Java bytecode programs on the JVM, Truffle also makes it possible for these languages to benefit from GraalVM’s advanced optimizing compiler technology to run faster and leaner — just like Java applications running on GraalVM.
In all cases GraalVM Truffle languages perform as fast as, and typically many times faster, on the JVM than they do when running on their original runtimes.

#### Breaking Down Walls

In addition to GraalVM being able to run programs written in a number of languages, it is also possible to run programs that use more than one!
There are thousands of useful Node.js packages, Python libraries, and Java libraries that can be used by any of the languages supported by GraalVM.
This enables use cases like Java microservices that incorporate Python machine learning capabilities or JavaScript programs that use R for statistical data analysis.

[GraalVM’s multilingual support](../../docs/reference-manual/polyglot-programming.md) makes it possible for developers with different language and domain expertise to collaborate.
For example, the Dutch National Police used GraalVM to integrate R code into Spring Boot web services written in Java and Scala.
This allowed their data scientists to write code in R to perform data analysis while their Java and Scala developers built out services that interacted with Apache Kafka.

<blockquote>Embedding R code in a Scala/JVM project can be an excellent way to use the powerful data processing packages accessible in R… This means you (or your Data Scientist) can use a specialized editor (e.g. RStudio) to create the R side of your functionality, while you can use your own favourite editor for the JVM side (e.g., IntelliJ).</blockquote>

<p class="quote-author" style="text-align: -webkit-right;"><strong>— Nathan Perdijk, Scala Developer, Codestar</strong></p>

<p style="text-align: -webkit-center;">
<a href='{{ "/docs/getting-started/" | relative_url }}' target="_blank" class="game-changer btn btn-primary">Quick start</a>
</p>
