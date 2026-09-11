---
layout: toc_content_ecosystem
title: GraalVM 25.2
link_title: GraalVM 25.2
permalink: "/release-notes/25.2/"
toc_group: release-notes
---

# GraalVM 25.2.4
(2026-07-28)

* [Platform and Distributions](#platform-and-distributions)
* [Native Image](#native-image)
* [GraalJS](#graaljs)
* [Truffle Framework](#truffle-language-implementation-framework)

## Platform and Distributions

* Released **GraalVM Community Edition 25.2.4**, an innovation release, based on OpenJDK 25.0.4+7. See [OpenJDK 25 Updates](https://jdk.java.net/25/){:target="_blank"}.
* Released **Oracle GraalVM 25.2.4**, an innovation release, based on Oracle JDK 25.0.4+7. See [Java SE 25 Release Notes](https://www.oracle.com/java/technologies/javase/25-relnote-issues.html){:target="_blank"}.
* Version compatibility:
    * GraalVM 25.2.4 is compatible with [Graal Languages and other components](https://www.graalvm.org/latest/reference-manual/languages) version **25.2.4**.

## Native Image

* Compressed 32-bit object references are now enabled by default, generally improving memory usage and performance. This limits the heap to 32 GB; disable compressed references with `-H:-UseCompressedReferences` when a larger heap is required.
* Native Image now always uses isolates. The deprecated `-H:+SpawnIsolates` option remains for compatibility, but `-H:-SpawnIsolates` is no longer supported and reports a build-time error.
* Removed the deprecated `-H:OutlineWriteBarriers` option. Use `-H:WriteBarrierOutlining=<value>` instead.
* Java Vector API support is enabled by default when `jdk.incubator.vector` is part of the boot module layer. Use `-H:-VectorAPISupport` to opt out explicitly.
* `resource:` URLs now preserve the source root of duplicate resource entries. This lets directory resources from separate class-path roots be converted to `Path` values and traversed independently.
* Added support for the `jdk.Shutdown` JFR event.

## GraalJS

* Updated Node.js to version 24.17.0.

## Truffle Framework

* Bytecode DSL added `BytecodeRootNode.interceptIncomingValue(Object)` and `BytecodeRootNode.interceptOutgoingValue(Object)` for converting values exchanged with tag instrumentation.
* Bytecode DSL added multi-operand support for `@Yield` operations.
* Bytecode DSL added `@Return` for user-defined return operations that customize the value returned from a bytecode root node.
* Added `HostCompilerDirectives.BytecodeInterpreterHandlerConfig#secondarySwitch()` to prevent handler outlining when a secondary bytecode interpreter switch is compiled separately.

Find a complete list of updates in the [Truffle Changelog](https://github.com/oracle/graal/blob/master/truffle/CHANGELOG.md#version-252).
