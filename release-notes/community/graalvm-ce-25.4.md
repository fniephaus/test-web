---
layout: toc_content_ecosystem
title: GraalVM 25.4
link_title: GraalVM 25.4
permalink: "/release-notes/25.4/"
toc_group: release-notes
---

# GraalVM 25.4.4.1.1
(2026-09-22)

* [Platform and Distributions](#platform-and-distributions)
* [Graal Compiler](#graal-compiler)
* [Native Image](#native-image)
* [Polyglot Runtime](#polyglot-runtime)
* [GraalJS](#graaljs)
* [GraalPy](#graalpy)
* [GraalWasm](#graalwasm)
* [Truffle Framework](#truffle-language-implementation-framework)

## Platform and Distributions

* Released **GraalVM Community Edition 25.4.4.1.1**, an innovation release, based on OpenJDK 25.0.4.1. See [OpenJDK 25 Updates](https://jdk.java.net/25/){:target="_blank"}.
* Released **Oracle GraalVM 25.4.4.1.1**, an innovation release, based on Oracle JDK 25.0.4.1. See [Java SE 25 Release Notes](https://www.oracle.com/java/technologies/javase/25-relnote-issues.html){:target="_blank"}.
* Version compatibility:
    * GraalVM 25.4.4.1.1 is compatible with [Graal Languages and other components](https://www.graalvm.org/latest/reference-manual/languages) version **25.4.4.1.1**.

## Graal Compiler

* Added `PullThroughPhiPhase` and `DuplicationPhase` to the compiler configuration. These optimizations are enabled by default and can be disabled with `-Djdk.graal.OptPullThroughPhi=false` and `-Djdk.graal.OptDuplication=false`, respectively.
* Extended read elimination to handle indexed array accesses with nonconstant indices, reads from newly allocated arrays whose elements contain default values, and array clone operations. Read elimination can now also run after reads are fixed in the low tier.
* Extended `OptimizeDivPhase` with magic-number optimizations for unsigned integer division and remainder operations by constant values.

## Native Image

* When native executables are built with `-H:+StrictRuntimeJavaOptions`, runtime assertion options such as `-ea`, `-da`, `-esa`, and `-dsa` configure the assertion status of runtime-loaded classes and runtime-initialized image classes. They do not affect build-time-initialized classes whose assertion status is only configured by `native-image -ea ...`.
* Defaulted to optional identity hash code fields with [Serial GC](https://www.graalvm.org/latest/reference-manual/native-image/optimizations-and-performance/MemoryManagement/#serial-garbage-collector). Few objects need one, and this optimization adds them during garbage collection. It can be disabled with `-H:-OptionalIdentityHashCodes`.
* Added outlining for `StringBuilder` and `StringBuffer` append sequences and `invokedynamic` string concatenations. This reduces the binary size of native executables.
* Added optimized stack overflow checks in method prologues and safepoint checks in method epilogues. Slow paths use tail calls to avoid setting up an additional frame.

#### Platform Updates

* On Linux AMD64, Native Image now records the selected x86-64 ISA level in `.note.gnu.property` for `-march` values requiring x86-64-v2 or newer, so tools such as `readelf` report the requirement correctly.

## Polyglot Runtime

* Added `HostAccess.Builder#allowPublicAccess(Predicate<Member>)` to selectively expose public host members without explicitly naming them upfront.
* Added `Feature.DuringSetupAccess#registerBuildTimeBootstrapIndy` and `Feature.DuringSetupAccess#registerBuildTimeBootstrapCondy`, allowing frameworks to register bootstrap methods for `invokedynamic` call sites and `CONSTANT_Dynamic` entries for execution at image build time.

## GraalJS

* Implemented the [`Await Dictionary`](https://github.com/tc39/proposal-await-dictionary) proposal. It is available in ECMAScript staging mode (`--js.ecmascript-version=staging`).

## GraalPy

* Removed BouncyCastle entirely. BouncyCastle was only needed for legacy RSA, DSA, and EC private keys versions 0 and 1. To support these from Python embeddings, BouncyCastle must now be explicitly enabled by adding the `org.graalvm.python:python-bouncycastle-support` Maven artifact and adding `bcprov-jdk18on`, `bcpkix-jdk18on`, and `bcutil-jdk18on` dependencies.

## GraalWasm

* Implemented the [Tail Call](https://github.com/WebAssembly/tail-call) proposal. This feature is enabled by default and can be disabled with the experimental option `--wasm.TailCalls=false`. The feature comes with an optimization that transforms direct recursive calls (functions calling themselves) into loops. This optimization is enabled by default and can be disabled with the experimental option `--wasm.TailCallLoops=false`.

## Truffle Framework

* Added host interoperability for `java.time.OffsetDateTime` and `java.time.OffsetTime`.
* Guest-language inlining now uses Graal IR call-site frequencies instead of runtime direct-call counters. Language implementations should ensure that injected branch probabilities are accurate because inaccurate probabilities are likely to cause peak-performance regressions.
* Added `StackValue`s to the Bytecode DSL for temporary stack operands through `BindStackValue`, `LoadStackValue`, and `StoreStackValue`.
* Added compressed source information to the Bytecode DSL. Compression is enabled by default and reduces source-table memory at the cost of slower decoding when source information is accessed.
* Removed APIs and methods deprecated in earlier releases, including Truffle Object APIs, Truffle Strings methods, `InteropException.initCause(Throwable)`, debugger APIs, instrumentation APIs, core Truffle APIs, and profile factory methods.
