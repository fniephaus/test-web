---
layout: toc_content_ecosystem
title: GraalVM 25.3
link_title: GraalVM 25.3
permalink: "/release-notes/25.3/"
toc_group: release-notes
---

# GraalVM 25.3.4.1
(2026-08-25)

* [Platform and Distributions](#platform-and-distributions)
* [Graal Compiler](#graal-compiler)
* [Native Image](#native-image)
* [Polyglot Runtime](#polyglot-runtime)
* [GraalJS](#graaljs)
* [GraalPy](#graalpy)
* [GraalWasm](#graalwasm)
* [Truffle Framework](#truffle-language-implementation-framework)

## Platform and Distributions

* Released **GraalVM Community Edition 25.3.4.1**, an innovation release, based on OpenJDK 25.0.4.1. See [OpenJDK 25 Updates](https://jdk.java.net/25/){:target="_blank"}.
* Released **Oracle GraalVM 25.3.4.1**, an innovation release, based on Oracle JDK 25.0.4.1. See [Java SE 25 Release Notes](https://www.oracle.com/java/technologies/javase/25-relnote-issues.html){:target="_blank"}.
* Version compatibility:
    * GraalVM 25.3.4.1 is compatible with [Graal Languages and other components](https://www.graalvm.org/latest/reference-manual/languages) version **25.3.4.1**.

## Graal Compiler

* Added priority inlining to GraalVM and made it the default inlining algorithm. This inlining algorithm does extensive analysis of the call graph when making inlining decisions (see [PriorityInliningPhase](#) for details). Also added `MethodDuplicationPhase`, which duplicates selected control-flow paths within a method to expose further optimization opportunities. You can restore the previous inliner with `-Djdk.graal.UsePriorityInlining=false`.
* Added loop-vectorization optimizations to GraalVM for eligible array-arithmetic loops. It transforms computations into SIMD instructions that process multiple values in parallel and can improve JIT performance in proportion to the target CPU's vector-register length. This optimization is enabled by default; disable it with `-Djdk.graal.VectorizeLoops=false`.

## Native Image

* Added `SubstratePriorityInliningPhase` to use the new priority inliner from the compiler suite.
* Added fast inline execution paths and optimized spinning for `synchronized`, improving locking performance. Disable the fast paths with `-H:-UseMonitorFastPath` when image size is a concern.
* Added `-H:CFI` control-flow integrity options. On AMD64, this protects indirect branches with software checks; on AArch64, it uses pointer authentication to protect return addresses.
* Improved runtime bytecode interpreter performance through tail-call threading among outlined bytecode handlers.
* Layer digest generation now handles large layer files. Layers created before this change might not be compatible with layers created afterward.
* With `-H:-LegacyJavaOptionMode`, VM options must appear before the first `--`; arguments after it are passed unchanged to the application main method.

## Polyglot Runtime

* Isolated polyglot contexts now warn when host access is enabled without host method scoping. Disable the warning with `engine.WarnMethodScoping=false`.

## GraalJS

* Implemented the [Iterator Includes](https://github.com/tc39/proposal-iterator-includes) proposal. It is available in ECMAScript staging mode (`--js.ecmascript-version=staging`).
* Implemented the [Iterator Join](https://github.com/tc39/proposal-iterator-join) proposal. It is available in ECMAScript staging mode (`--js.ecmascript-version=staging`).
* Implemented the [Iterator Chunking](https://github.com/tc39/proposal-iterator-chunking) proposal. It is available in ECMAScript staging mode (`--js.ecmascript-version=staging`).
* Updated Node.js to version 24.18.1.

## GraalPy

* Updated the Python standard library to version 3.13.14 and implemented new Python 3.13 features.

## GraalWasm

* Added support for the [branch-hinting](https://github.com/WebAssembly/branch-hinting) custom section, enabling optimized code generation from `if` and `br_if` likelihood hints.
* Added the `table64` portion of the [Memory64](https://github.com/WebAssembly/memory64/blob/main/proposals/memory64/Overview.md) proposal. Enable it with `--wasm.Memory64`.
* Added the [Wide Arithmetic](https://github.com/WebAssembly/wide-arithmetic) proposal, including `i64.add128`, `i64.sub128`, `i64.mul_wide_s`, and `i64.mul_wide_u`. This experimental feature is disabled by default; enable it with `--wasm.WideArithmetic=true`.

## Truffle Framework

* Improved descriptive `toString()` output for Polyglot API objects and builders.
* Added `StaticShape.Builder.safetyChecks(boolean)` to configure safety checks for individual static shapes. `engine.ForceStaticObjectSafetyChecks` enables checks for all static shapes, overriding the builder setting.
* Setting `sandbox.MaxCPUTime` to a zero duration now disables the CPU-time limit.
* Bytecode DSL `Source` and `SourceSection` are now metadata-only operations that do not affect the operation-tree shape. The previous sequencing semantics were unsound and could produce inconsistent behavior between reparses.
* Bytecode DSL source-section tables no longer emit entries for empty bytecode ranges and combine adjacent ranges only when they come from the same `SourceSection` operation.
