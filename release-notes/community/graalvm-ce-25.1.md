---
layout: toc_content_ecosystem
title: GraalVM 25.1
link_title: GraalVM 25.1
permalink: "/release-notes/25.1/"
toc_group: release-notes
---

# GraalVM 25.1.3
(2026-06-30)

* [Platform and Distributions](#platform-and-distributions)
* [Graal Compiler](#graal-compiler)
* [Native Image](#native-image)
* [GraalJS](#graaljs)
* [GraalPy](#graalpy)
* [GraalWasm](#graalwasm)
* [Polyglot Runtime](#polyglot-runtime)
* [Truffle Framework](#truffle-language-implementation-framework)

## Platform and Distributions

* Starting with the 25.1 release line, GraalVM provides innovation (feature) releases on a monthly cadence with quarterly Critical Patch Updates (CPUs) incorporated when available. Previously, feature releases were shipped every six months, with each release receiving two quarterly CPUs before being superseded by the next feature release. The most recent feature release supersedes the previous feature release.
* Released **GraalVM Community Edition 25.1.3** based on OpenJDK 25.0.3+9. See [OpenJDK 25 Updates](https://jdk.java.net/25/){:target="_blank"}.
* Released **Oracle GraalVM 25.1.3** based on Oracle JDK 25.0.3+9. See [Java SE 25 Release Notes](https://www.oracle.com/java/technologies/javase/25-relnote-issues.html){:target="_blank"}.
* Version compatibility:
    * GraalVM 25.1.3 is compatible with [Graal Languages and other components](https://www.graalvm.org/jdk25/reference-manual/languages) version **25.1.3**.

## Graal Compiler

* Enabled the use of the `graal.` prefix for compiler options without issuing a warning (in addition to `-Djdk.graal`).
* Added support for recording and replaying JIT compilations. The `-Djdk.graal.RecordForReplay=*` option serializes all compilations matching the pattern to JSON files, which contain the results of JVM Compiler Interface (JVMCI) calls. The recorded compilations can be replayed with the `mx replaycomp` command. Truffle compilations are currently not supported. For details, see the documentation [Replay Compilation](https://github.com/oracle/graal/blob/master/compiler/docs/ReplayCompilation.md).
* Added a new disassembly tool that can disassemble `HexCodeFile` sections in `.cfg` files and `MachCode` sections in HotSpot `hs_err_pid` files. Run the tool with `mx`, for example: `mx distool hs_err_pid5677.log`.
* Added optional constant blinding for untrusted code. Enable it with `-Djdk.graal.BlindConstants=true`.

## Native Image

### New Features and Improvements

* Reduced Native Image size by compacting image heap metadata and storage, including module metadata, runtime dynamic-access metadata, and symbol table data, and intrinsifying simple constant `String.format` and `String::formatted` calls. This reduces the size of a HelloWorld application on Linux AMD64 to ~6.5 MB.
* Added support for using G1 GC in Native Image on macOS AArch64 (Oracle GraalVM-only feature).
* Added a new tool, `--tool:llvm-backend`, to enable the LLVM backend for Native Image.
* Introduced `--future-defaults=class-for-name-respects-class-loader` that changes `Class.forName` and `ClassLoader#loadClass` to respect the class loader arguments.
* Introduced a new value for `--future-defaults=run-time-initialize-resource-bundles` that shifts away from build-time initialization for `java.util.ResourceBundle`. Unless you store `ResourceBundle`-related classes in the image heap, this option should not affect you. In case this option breaks your build, follow the suggestions in the error messages.
* Made `--future-defaults=complete-reflection-types` default. All reflective operations on types registered for reflection will now return complete results.
* The context class loader seen during build-time context initialization is now part of the `native-image` module layer. This means that, by default, service loaders will now see extra service provider definitions from the `native-image` module path.
* `JNI_CreateJavaVM` now runs Native Image startup hooks by default for JNI-created VMs. If your image must delay startup hooks until a later explicit `VMRuntime.initialize()` call, use `-H:-InitializeVM`.
* Made `ParseRuntimeOptions` a non-experimental option and extracted a separate experimental `InitializeVM` flag. If your project previously used `ParseRuntimeOptions` and you call `VMRuntime.initialize()` manually, you might have to disable the new option.
* The `-H:` options can now be used at build time to set defaults for both build-time and run-time options. For example, the run-time option `-R:MaxHeapSize` can now also be set via `-H:MaxHeapSize`.
* Added randomized runtime code entry points via `-H:+MaxRuntimeCodeOffset`.
* Relative code pointers are now enabled by default for position-independent executables (PIE) and shared library images. They can be disabled with `-H:-RelativeCodePointers`.
* Added component hashes to the SBOM `-H:+MemoryMaskingAndFencing` (Oracle GraalVM-only feature). Users can now benefit from strengthened integrity verification by comparing the SBOM digests with those published to trusted sources like Maven Central.
* Removed all support for running the `native-image` builder on classpath.
* Renamed the `native-image-configure` tool to `native-image-utils`.
* Added a new API option `-Werror` to treat warnings as errors.
* Added size warnings for bundles created with `bundle-create` when individual or total file sizes exceed configured limits. Configure these limits using the `size-warning-file-limit` and `size-warning-total-limit` options (values in MiB).
* Moved `native-image-utils extract-sbom` to GraalVM Community Edition.
* Added the `--print-options` flag to `native-image` for printing available options in table, Markdown, or JSON format.

#### Performance Improvements

* Introduced a new [Serial GC](https://www.graalvm.org/latest/reference-manual/native-image/optimizations-and-performance/MemoryManagement/#serial-garbage-collector) policy, `Adaptive2`, which uses mark-compact collection in the old generation by default. On average, this reduces memory usage and often improves throughput and latency. To restore the previous behavior, use: `-H:-CompactingOldGen -H:InitialCollectionPolicy=Adaptive`.
* Serial GC collection policy can now be selected at run time with `-XX:InitialCollectionPolicy`.

#### Debugging and Monitoring Improvements

* Added the `jitdump` support for recording run-time compilation metadata for `perf` (see [Perf Profiler Support in Native Image](https://www.graalvm.org/latest/reference-manual/native-image/debugging-and-diagnostics/perf-profiler/)). It can be enabled with `-g -H:+RuntimeDebugInfo -H:RuntimeDebugInfoFormat=jitdump`.
* Added POSIX support for Native Image JFR emergency dumps. When an `OutOfMemoryError` occurs while a JFR recording is active, Native Image can preserve in-memory recording data in an emergency JFR file.
* JFR now uses the safepoint-based execution sampler by default on all platforms.
* JFR stack traces are no longer disabled entirely with runtime compilation; traces containing JIT-compiled code are skipped individually.

#### Improved Compatibility

* Added an early version of dynamic class loading for libraries and tools that generate JVM bytecode at run time, such as Byte Buddy. It also enables more plugin use cases, such as dynamically loading `javac` annotation processors. To enable dynamic class loading, pass `-H:+RuntimeClassLoading` to the `native-image` tool.
* Introduced `-H:+CompatibilityMode` that aligns Native Image execution more closely with standard Java semantics by disabling implementation-specific behavior.
In this mode, the following features are disabled: build-time initialization of classpath classes, native-image-specific system properties, classpath substitutions, user-defined features. This mode does not modify key restrictions related to dynamic access (reachability metadata) and run-time class loading as those are accepted limitations of Native Image.
For behavior closer to the JVM, consider combining this mode with:
  ```bash
  native-image -H:+CompatibilityMode -H:Preserve=all -H:+RuntimeClassLoading App
  ```
* Improved the schema to capture detailed constraints about each element in the _reachability-metadata-schema.json_ file.
* The _reachability-metadata-schema.json_ file is now included in the GraalVM distribution at `<graalvm-home>/lib/svm/schemas/reachability-metadata-schema.json`, making the schema available locally without requiring a separate download.
* `-H:Preserve` now preserves reached lambda proxy classes whose capturing classes are preserved.
* Added `-XX:TraceMetadataConditionPackages` for collecting conditional reachability metadata from a native image at run time.
* Improved URL protocol reachability metadata collection. `--enable-url-protocols` is now deprecated in favor of reachability metadata.
* Made bundle path maps portable across platforms; bundle format is now 1.0, with backward compatibility.

#### Platform Updates

* On macOS, the build process now uses `memory_pressure` instead of `vm_stat` for a more accurate detection of free memory.
* Added Windows support for Native Image JFR recordings and heap dumps.
* Linux builds now produce position-independent executables (PIE) by default. This can be disabled with `-H:NativeLinkerOption=-no-pie`.

#### Deprecated Functionality

* Deprecated the `native-image-inspect` tool. To extract embedded SBOMs, use `native-image-utils extract-sbom --image-path=<path_to_binary>`.
* Deprecated `native-image-utils generate-filters`; the agent now applies built-in filters by default.
* Removed the Fallback feature. The `--no-fallback` flag is deprecated and no longer has any effect, and other related options have been removed.
* Deprecated the API method `Threading.registerRecurringCallback(...)` without replacement. This method should not be used as it is inherently unsafe.
* Removed the deprecated API method `ProcessPropertiesSupport.setLocale(...)`.
* Removed the deprecated `@AutomaticFeature` annotation and its handling. Features should be registered via the `--features` argument.

### Web Image

* [Web Image](https://www.graalvm.org/latest/reference-manual/web-image/) is a recently introduced **experimental** backend for GraalVM Native Image that compiles a Java application ahead-of-time and produces a WebAssembly (Wasm) module with a JavaScript wrapper. Then it can be run in browsers, Node.js, or on the GraalJS-based Node runtime. It is available with Oracle GraalVM 25.1 or later. Web Image is enabled by passing the `--tool:svm-wasm` option to the `native-image` tool. Find some examples and more documentation in the [demos repository](https://github.com/graalvm/graalvm-demos/tree/master/web-image).

## GraalJS

* ECMAScript 2026 mode/features are enabled by default.
* Updated Node.js to version 24.14.1.
* Finished support for [Temporal](https://github.com/tc39/proposal-temporal). It is available in ECMAScript 2027 mode (`--js.ecmascript-version=2027`).
* Implemented the [`Explicit Resource Management`](https://github.com/tc39/proposal-explicit-resource-management) proposal. It is available behind the experimental option `--js.explicit-resource-management`.
* Implemented the [`Joint Iteration`](https://github.com/tc39/proposal-joint-iteration) proposal. It is available in ECMAScript staging mode (`--js.ecmascript-version=staging`).
* Implemented the [`Import Text`](https://github.com/tc39/proposal-import-text) proposal. It is available behind the experimental option `--js.import-text`.
* Implemented the [`Import Bytes`](https://github.com/tc39/proposal-import-bytes) proposal. It is available behind the experimental option `--js.import-bytes`.
* Implemented the [`Error Stack Accessor`](https://github.com/tc39/proposal-error-stack-accessor) proposal. It is available behind the experimental option `--js.error-stack-accessor`.
* Removed support for legacy import assertions (`import ... assert {type: "..."}`) and the `--js.import-assertions` option. Use import attributes (`import ... with {type: "..."}`) and the `--js.import-attributes` option instead.
* Removed support and builds for macOS x86-64 (darwin-amd64).
* Added an experimental option `js.crypto` that provides `getRandomValues()` and `randomUUID()` from the [Web Crypto API](https://w3c.github.io/webcrypto/#crypto-interface).
* Added stable option `js.performance` that provides `performance.now()`, `timeOrigin`, and `toJSON()` from the [Web High Resolution Time API](https://w3c.github.io/hr-time/).
* Implemented the [`Immutable ArrayBuffers`](https://github.com/tc39/proposal-immutable-arraybuffer) proposal. It is available in ECMAScript staging mode (`--js.ecmascript-version=staging`).
* Limited Chrome inspector remote debugging to localhost.
* The JavaScript polyglot isolate now includes support for WebAssembly (Wasm).

## GraalPy

* The standalone artifacts now include the Python version before the GraalVM version in their names. Artifact names now start with `graalpy<PYTHON_VERSION>-<GRAAL_VERSION>-<OPERATING_SYSTEM>-<ARCHITECTURE>`.
* Standalone JVM artifacts are no longer released as separate distributions. For standalone deployments, use the GraalPy native artifacts. For Java interoperability, use the jbang launcher (`jbang graalpy@oracle/graalpython -c "print('hello from GraalPy')"`) or a custom embedding.
* Added `-X jit=0|1|2` presets to tune startup-heavy or throughput-oriented workloads. The GraalPy launcher now defaults to the `jit=1` preset.
* Interned string literals in source files.
* Improved `readline` support via JLine. Autocompletion and history now work in `pdb`.
* Added GitHub workflows that run the same gates as internal CI. This helps contributors ensure their PRs pass the same tests run internally.
* Dispatch `sys.audit` events to hooks registered with `sys.addaudithook`, including audit events raised through the `PySys_Audit` C API.
* The GraalPy Native standalone on Linux now uses a lower-footprint Native Image garbage collection configuration. This reduces resident set size (RSS) for many workloads, but may increase startup or warmup time and can slow down some workloads.
* Replaced the intrinsified `_ctypes` module with the native CPython version. This makes GraalPy's `ctypes` implementation more compatible and reduces the memory footprint of using `ctypes`.
* Removed allocation reporting via Truffle. Python object sizes were never reported correctly, so the data was misleading. Reporting also added non-negligible overhead even when inactive.

### GraalPy Embedding in Java

* Added a new, more natural style of subclassing Java classes from Python by passing the `new_style=True` keyword. Multiple levels of inheritance are supported, and `super()` calls both in the constructor override via `__new__` as well as in Java method overrides work as expected.
* Added the `polyglot.gil_locked_during_interop` context manager. By default, the global interpreter lock (GIL) is released when interacting with foreign objects to allow other Python threads to run in parallel. This context manager keeps the GIL held for short-running interop, reducing repeated lock/unlock overhead.
* Foreign buffer objects are now treated as Python buffer-compatible binary objects, so APIs such as `memoryview`, `bytes`, `bytearray`, `binascii.hexlify`, and `io.BytesIO` work naturally on them when embedding GraalPy in Java.
* Added support for specifying generics on foreign classes and inheriting from them. This allows expressing generic types in Python type annotations, especially when using Java classes that support generics.
* Added a Java backend for the `pyexpat` module that uses a Java XML parser instead of the native `expat` library. This is the default for embeddings and can be switched back to native `expat` with the `python.PyExpatModuleBackend=native` option.
* Added the `python.UnicodeCharacterDatabaseNativeFallback` context option to control whether the ICU database may fall back to CPython's native Unicode character database.
* Added the `python.AllowSignalHandlers` context option to control whether Python code may install signal handlers. It is disabled by default for Java embeddings and enabled in the standalone.
* Added the experimental `python.InitializationEntropySource` option to control the entropy source used for initialization-only randomness.
* Foreign temporal objects, such as dates, times, and time zones, are now given Python classes corresponding to their interop traits: `date`, `time`, `datetime`, or `tzinfo`.
* Made BouncyCastle an optional dependency for embedding use cases. To support legacy RSA, DSA, and EC private key versions 0 and 1 from Python embeddings, explicitly add the `org.graalvm.python:python-bouncycastle-support` Maven artifact.

## GraalWasm

* Adopted a bytecode-handler-based design for the WebAssembly interpreter, improving interpreted performance when GraalWasm runs as a native image.
* Implemented the legacy exception handling proposal. It is disabled by default and can be enabled independently with the experimental option `wasm.LegacyExceptions=true`.
* Implemented the [exception handling](https://github.com/WebAssembly/exception-handling) proposal. This feature is enabled by default and can be disabled with the experimental option `wasm.Exceptions=false`.
* Implemented the [typed function references](https://github.com/WebAssembly/function-references) proposal. This feature is enabled by default and can be disabled with the experimental option `wasm.TypedFunctionReferences=false`.
* Enabled the standardized features [Extended Constant Expressions](https://github.com/WebAssembly/extended-const/blob/master/proposals/extended-const/Overview.md), [Multiple Memories](https://github.com/WebAssembly/multi-memory/blob/master/proposals/multi-memory/Overview.md), and [Relaxed SIMD](https://github.com/WebAssembly/relaxed-simd/tree/main/proposals/relaxed-simd) by default.
* Implemented the [GC](https://github.com/WebAssembly/gc) proposal. This feature is enabled by default and can be disabled with the experimental option `wasm.GC=false`.

## Polyglot Runtime

* Isolated `Engine` and `Context` are now available in GraalVM Community Edition. They can be enabled with `engine.SpawnIsolate=true`; for community language libraries, use `-isolate-community` artifacts such as `js-isolate-community`.
* `SandboxPolicy.ISOLATED`, `SandboxPolicy.UNTRUSTED`, and sandbox resource limits are now supported in GraalVM Community Edition.
* Added `Context.Builder#spawnIsolate(boolean)` and `Engine.Builder#spawnIsolate(boolean)` to configure polyglot isolates directly. If a permitted language is unavailable on the class path or module path but a polyglot isolate for that language is present, the isolated language is selected automatically.
* Starting with Polyglot 25.1, the optimizing Truffle runtime is supported only with GraalVM 25.1 or later, including Oracle GraalVM and GraalVM Community Edition. It is no longer supported with GraalVM 25.0 or earlier, or on plain OpenJDK or Oracle JDK via `jargraal` (`org.graalvm.compiler:compiler` on `--upgrade-module-path`). The fallback runtime remains supported on standard JDKs and remains backward compatible down to JDK 21, but runs without runtime compilation. If you need the optimizing runtime on plain OpenJDK or Oracle JDK, continue using the 25.0 LTS release.
* Introduced the `-Dpolyglot.engine.allowUnsupportedPlatform=true` system property to enable the Truffle framework to run on unsupported platforms. When enabled, this property suppresses the unsupported-platform failure. See follow-up errors and warnings for instructions on how to continue. Note that using an unsupported platform will also force the fallback runtime without runtime optimization.
* If neither a log handler nor the `log.file` option is set on the `Engine.Builder` or `Context.Builder`, Truffle and language log messages will be written to the Context’s error output stream by default. The `log.file` option is now also supported on `Context.Builder`.
* Made `--polyglot` the default for language launchers, so there is no need to specify it anymore to use other languages in standalones. As a result, `AbstractLanguageLauncher#getDefaultLanguages()` and `Launcher#canPolyglot()` have been deprecated.
* Closing a garbage-collected engine or context now logs only the first failure by default. To log all failures, use `engine.CloseOnGCFailureAction.PrintAll`.
* `Engine.getVersion()` now returns the Truffle API version rather than the GraalVM version.
* Polyglot isolate hosts now use the fallback Truffle runtime by default, enabling isolate hosting on JDKs that do not support the optimized Truffle runtime.
* Added constant-option support and native-image preset options. Selected polyglot option values can now be fixed before runtime initialization or captured as native-image build-time defaults.
* Added `Engine.supportsCompilation()` to check whether the current host runtime supports optimized guest language execution.
* Added `FileSystem#allowInternalResources(FileSystem)`, allowing embedders to expose internal resources and language homes through a read-only view of the default file system when using a custom file system.

Find a complete list of updates in the [changelog](https://github.com/oracle/graal/blob/master/sdk/CHANGELOG.md#version-2510).

## Truffle Framework

* Multiple improvements in the `DynamicObject` API: introduced `DynamicObject` nodes as a lighter replacement for `DynamicObjectLibrary`, and deprecated `DynamicObjectLibrary`. See the [migration guide](https://github.com/oracle/graal/blob/master/truffle/docs/DynamicObjectLibraryMigration.md).
* Bytecode DSL performance improvements: specialization state and primitive constants are now encoded directly in bytecode, and threaded switch execution is enabled by default for bytecode interpreters.
* Bytecode DSL runtime and diagnostics improvements: added generated bytecode descriptors (`BytecodeDescriptor`/`InstructionDescriptor`) and instruction-level tracing/histogram options (`engine.TraceBytecode`, `engine.BytecodeHistogram`).
* Bytecode DSL stack-trace support improvements: introduced `BytecodeFrame` and optional frame capture in `TruffleStackTraceElement`s for more reliable frame data in traces.
* Added more Bytecode DSL runtime support, including lazy source-content loading, generated `BytecodeRootNode#getSource()`, stricter bytecode-index validation, frame-walk helpers, and improved generated root-node delegation.
* Interop API modernization: `InteropLibrary#hasLanguage`/`getLanguage` were replaced by `hasLanguageId`/`getLanguageId`; new host interop methods on `InteropLibrary` were added and corresponding `Env` host-object APIs were deprecated.
* Host adapter instances created with `TruffleLanguage.Env#createHostAdapter` now delegate unresolved direct member operations to the original guest object.
* Truffle DSL behavior change: single-specialization nodes no longer specialize on first execution unless needed (assumptions/cached state/multiple instances), improving interpreter footprint and startup behavior.
* Added support for passing primitive arrays to native code through the Truffle NFI Panama backend.
* Debugger stepping behavior was refined: pending steps are now independent from breakpoint handling and thread resume operations.
* Improved optimized performance of host proxy interfaces (`org.graalvm.polyglot.proxy.Proxy`).
* Added compiler guidance APIs for partial evaluation, including `@HostCompilerDirectives.InliningRoot` and `@CompilerDirectives.EarlyInline`/`@CompilerDirectives.EarlyEscapeAnalysis`.
* Added new Truffle engine options for compilation tuning, including `engine.DynamicCompilationThresholdsHighLoadSlope` for high-load threshold scaling and `engine.CompilerThreadStackSize` for configuring compiler thread stack size.
* Added `Engine.persistCache(Engine.CancellationCallback)` to persist the auxiliary engine cache into an in-memory `ByteBuffer` with cancellation support.
* Added support for constant polyglot options and native-image preset options, allowing selected option values to be fixed before runtime initialization or captured as native-image build-time defaults.

Find a complete list of updates in the [Truffle changelog](https://github.com/oracle/graal/blob/master/truffle/CHANGELOG.md#version-251).
