---
layout: toc_content_ecosystem
title: GraalVM 25.5
link_title: GraalVM 25.5
permalink: "/release-notes/25.5/"
toc_group: release-notes
---

# GraalVM 25.5.5.0.3
(2026-11-03)

* [Platform and Distributions](#platform-and-distributions)
* [Graal Compiler](#graal-compiler)
* [Native Image](#native-image)
* [Polyglot Runtime](#polyglot-runtime)
* [GraalJS](#graaljs)
* [GraalPy](#graalpy)
* [Truffle Framework](#truffle-language-implementation-framework)

## Platform and Distributions

* Released **GraalVM Community Edition 25.5.5.0.3**, an innovation release based on OpenJDK 25.0.5.0.3. See [OpenJDK 25 Updates](https://jdk.java.net/25/){:target="_blank"}.
* Released **Oracle GraalVM 25.5.5.0.3**, an innovation release based on Oracle JDK 25.0.5.0.3. See [Java SE 25.0.5 Release Notes](https://www.oracle.com/java/technologies/javase/25-0-5-relnotes.html){:target="_blank"}.
* Version compatibility: GraalVM 25.5.5.0.3 is compatible with [Graal Languages and other components](https://www.graalvm.org/latest/reference-manual/languages) version **25.5.5.0.3**.
* Updated Java's certificate trust configuration to address the eMudhra certificate incident: compromised intermediate CA certificates are now distrusted, and related eMudhra and Comodo root CA certificates are removed. See [CVE-2026-91403](https://www.oracle.com/security-alerts/alert-cve-2026-91403.html){:target="_blank"} and [CVE-2026-114820](https://www.oracle.com/security-alerts/alert-cve-2026-114820.html){:target="_blank"}.

## Graal Compiler

* Added aggressive partial loop unrolling and simulation-based loop peeling compiler optimization. Aggressive partial unrolling is enabled by default and can be disabled with `-Djdk.graal.AggressivePartialUnroll=false`. The original simple partial unrolling remains available, and all partial unrolling is controlled by the master `-Djdk.graal.PartialUnroll=false` option.
* Added `RangeCheckEliminationPhase`, which rewrites eligible 64-bit range checks to equivalent 32-bit forms after counted strip mining. The optimization is enabled by default and can be disabled with `-Djdk.graal.RangeCheckElimination=false`.
* Added `BreakChainedPhisPhase`, which splits chained loop phi values in the low tier to improve register allocation. The optimization is enabled by default and can be disabled with `-Djdk.graal.BreakChainedPhis=false`.
* Added partial redundancy elimination scheduling to the community compiler. The optimization is enabled by default and can be disabled with `-Djdk.graal.PartialRedundancyScheduling=false`.
* Added a write sinking optimization that moves eligible field and constant-offset array writes out of loops. The optimization is enabled by default and can be disabled with `-Djdk.graal.OptWriteSinking=false`.
* Added a deduplication optimization that can reduce generated code size by sharing equivalent statements and expressions from converging control-flow branches. The optimization is enabled by default and can be disabled with `-Djdk.graal.OptDeDuplication=false`.
* Extended lock elimination to coarsen locks across simple control flow and eliminate nested locking of the same object.
* Added `GuardRangeGroupingPhase`, which removes redundant integer range guards by retaining the tightest lower and upper bounds for guards with the same anchor. The optimization is enabled by default and can be disabled with `-Djdk.graal.OptGuardRangeGrouping=false`.
* Added an optimization that replaces eligible loop-carried memory reads with value phis, allowing invariant reads to move out of the loop. The optimization is enabled by default and can be disabled with `-Djdk.graal.OptimizeLoopAccesses=false`.
* Added early checkcast expansion to expose null and type checks as control flow for subsequent optimizations. It is enabled by default and can be disabled with `-Djdk.graal.EarlyExpandCheckCast=false`.
* Added speculative store checks, which can remove array store checks by speculating that an array's declared type is exact. The optimization is enabled by default and can be disabled with `-Djdk.graal.SpeculativeStoreCheck=false`.
* Added strip mining for counted and non-counted loops, loop inversion, loop rotation, and exact arithmetic optimization. Strip mining bounds long-running loop bodies to reduce safepoint overhead, loop inversion transforms while loops into guarded do-while loops to improve instruction pipelining, and loop rotation transforms selected non-counted loops into counted loops by duplicating loop-body code. Exact arithmetic optimization replaces exact additions with normal additions while preserving overflow behavior through loop-limit deoptimization. These optimizations are enabled by default and can be controlled with their corresponding options, including `-Djdk.graal.LoopRotation=false` and `-Djdk.graal.OptExactArithmetic=false`.

## Native Image

* Added the `org.graalvm.nativeimage.graalos` Java system property to identify images built for [GraalOS](https://graal.cloud/graalos/) at build time and runtime.
* Native Images built with `--enable-monitoring=jvmstat` can attach to file-backed JVMStat performance data from other HotSpot and Native Image processes on Linux and macOS. JDK tools such as `jstack`, `jinfo`, `jps`, and `jstat` can run on [Crema](https://github.com/oracle/graal/issues/11327) to inspect other JVM processes.
* Added an unboxed calling convention for compiled Truffle-to-Truffle calls.
* Unrecognized Native Image options starting with `-` or `--` now produce an error instead of being interpreted as a main class or output filename. This also rejects positional output names beginning with a dash. To keep using such a name, specify it with `-o`, for example `native-image -jar hello.jar -o --my-image`, or prefix the positional name with `./`.
* Updated the bundle format to version 2.0, with explicit path root kinds, build argument groups that retain their source platform, and persistent markers for unavailable inputs. Older bundle formats remain readable.
* Added auxiliary images, a mechanism for persisting runtime-allocated objects and runtime-compiled code and loading them in later executions of the same native image.

## Polyglot Runtime

* Added support for [auxiliary engine caching](https://github.com/oracle/graal/blob/master/truffle/docs/AuxiliaryEngineCaching.md) in GraalVM Community Edition.
* Added `FileChannel`. On JDK 22 and later, its `map` method maps file regions to `MemorySegment` instances whose lifetime is controlled by a caller-provided `Arena`.
* Added file-locking support to `FileChannel` through the `lock` and `tryLock` methods.
* Documented `Context` and `Engine` lifecycle management, including the conditions for automatic closure. For more information, see the [Embedding Languages documentation](https://github.com/oracle/graal/blob/master/docs/reference-manual/embedding/embed-languages.md#manage-the-lifecycle-of-contexts-and-engines).

## GraalJS

* Added `js.foreign-object-prototype=specialized-only` mode to make generic foreign objects inherit directly from `Object.prototype`, improving compatibility with `Object.getPrototypeOf(foreign) === Object.prototype` checks. Specialized foreign prototypes and the existing `true` (default) and `false` modes are unchanged.

## GraalPy

* Added `select.poll()` on Linux and macOS.
* Improved Windows console support and Windows version reporting.

## Truffle Framework

* Added `HostCompilerDirectives.BytecodeInterpreterHandlerConfig.enableTailDuplication()` to opt threaded bytecode handlers into dispatch-tail duplication. It is disabled by default.
* Added `CompilerDirectives.mergeExplodeKey()` to explicitly mark a local variable as a key for `@ExplodeLoop(MERGE_EXPLODE)` methods. Migrate merge-exploded loops to use this method to catch unintended graph size explosions.
* Extended `HostCompilerDirectives.BytecodeInterpreterHandlerConfig.Argument.Field.templateVariable()` to support per-field template variant counts for bytecode handler threading, and added template-aware main dispatch from the switch loop.
* `TruffleFile.newByteChannel` now returns `FileChannel`, enabling file regions to be mapped to `MemorySegment` instances on JDK 22 and later.
* `FileChannel` instances returned by `TruffleFile.newByteChannel` now expose file locking through the `lock` and `tryLock` methods when supported by the underlying file system.
* Made the Bytecode DSL ClearLocal builtin non-optional. Rename custom operations that conflict with this builtin.
* Added `DynamicObject.SetAllPropertyFlagsNode` to update flags of multiple existing properties without assigning their values. It supports uniform flags, per-key flags, and remove/add masks.
* Added `HostCompilerDirectives.BytecodeInterpreterHandlerConfig.Argument.expandedType()` to select an exact concrete class for virtual argument expansion. Added `Argument.Field.validWhen()` and `valid()` to control incoming field validity by template state.
* Added `GenerateBytecode.unwindExceptions` to the Bytecode DSL to select exceptions that run finally cleanup while bypassing guest catches and exception interception, preserving exception identity across suspension and resumption.
* Added `PropertyGetter.getShape()` to expose the shape accepted by a property getter.
