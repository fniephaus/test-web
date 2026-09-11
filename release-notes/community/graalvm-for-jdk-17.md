---
layout: toc_content_ecosystem
title: GraalVM for JDK 17
link_title: GraalVM for JDK 17
permalink: "/release-notes/JDK_17/"
toc_group: release-notes
---

# GraalVM for JDK 17.0.9
(2023-10-24)

This is the October 2023 Critical Patch Update (CPU) for GraalVM Community Edition.
It is based on the OpenJDK CPU and includes all the OpenJDK security fixes released as part of that CPU, platform updates, and some GraalVM features bug fixes.
It is a full distribution and supersedes the previous release of GraalVM Community Edition for JDK 17.0.8.

* Updated _GraalVM Community Edition for JDK 17_ to **17.0.9+9**. See the [OpenJDK 17 Updates](https://wiki.openjdk.org/display/JDKUpdates/JDK+17u "OpenJDK 17 Updates").
* Version compatibility:
    * [Truffle languages and other components](https://www.graalvm.org/jdk17/reference-manual/#specific-languages) version **23.0.2** are designed for use with **GraalVM for JDK 17.0.9**.
* Compiler fixes:
    * Fixed alternating `Phi` wrongly detected as induction variable.
    * Fixed macOS AArch64 miscompilation.
* Native Image fixes: 
    * Re-throw feature exceptions as user errors.
    * Properly set `exceptionTemp` for foreign calls.
    * Ignore accessors of `RecordComponents` when `null`.
    * Improved build reports.
    * Do not annotate non-final JDK methods as uninterruptible.
    * Fixed incorrect buffer pool adjustment during sampler start.
    * Made the physical memory size initialize eagerly.
    * Fixed "New VarHandle found after static analysis" in Netty 5.
* Truffle framework fixes:    
    * Fixed a `NullPointerException` when using isloates in JIT mode and sharing engine if the context is not closed.
    * Disconnected `polyglot.Value` instances created from `BigInteger` values should not return false by default for `isNumber().`
    * Fixed a `NullPointerException` in `AbstractTruffleString.equals()` method.
    * Fixed a deadlock in `PolyglotStackFramesRetriever`.
    * Disallowed untrusted code hardware mitigations until MPK support is complete.

# GraalVM for JDK 17.0.8
(2023-07-25)

This is the July 2023 Critical Patch Update (CPU) for GraalVM Community Edition.
It is based on the OpenJDK CPU and includes all the OpenJDK security fixes released as part of that CPU, platform updates, and some GraalVM features bug fixes.
It is a full distribution and supersedes the previous release of GraalVM Community Edition for JDK 17.0.7.

* Updated the OpenJDK release on which GraalVM Community Edition is built to **17.0.8+7**. See the [OpenJDK 17 Updates](https://wiki.openjdk.org/display/JDKUpdates/JDK+17u "OpenJDK 17 Updates").
* Graal compiler: Updated counted strip mining optimization to do not strip mine overflowing loops.
* Native Image: Fixed `jvmstat` performance data initialization.
* Native Image: Fixed JDK Flight Recorder (JFR) events constant pool IDs.
* Native Image: Fixed user experience issues in Native Image.
* Native Image: Fixed analysis results in build reports.

# GraalVM for JDK 17.0.7
(2023-06-13)

* [Platform Updates](#platform-updates)
* [Java and Compiler Updates](#java-and-compiler-updates)
* [Native Image](#native-image)
* [JavaScript and Node.js](#javascript-and-nodejs)
* [Polyglot Embedding](#polyglot-embedding)
* [Truffle Language and Tool Implementations](#truffle-language-and-tool-implementations)
* [Java on Truffle](#java-on-truffle-espresso)
* [Python](#python)
* [Ruby](#ruby)
* [LLVM](#llvm)
* [WebAssembly](#webassembly)

### Platform Updates

* Released **GraalVM Community Edition for JDK 17** based on OpenJDK 17.0.7+8. See [OpenJDK 17 Updates](https://jdk.java.net/java-se-ri/17).
* Simplified the GraalVM package naming: it is `graalvm-community-jdk-<full java version>_<platform>-<arch>`, for example: _graalvm-community-jdk-17.0.7_macos-aarch64_bin.tar.gz_.

### Java and Compiler Updates

* Added support for the [ZGC garbage collector](https://docs.oracle.com/en/java/javase/20/gctuning/z-garbage-collector.html) for workloads that require low latency or use a very large heap size. See [#2149](https://github.com/oracle/graal/issues/2149).
* Strengthened the optimistic aliasing analysis by adding a non-speculative mode. (Improves loop vectorization.) Some code shapes were previously only vectorized in JIT, but not in ahead-of-time compilations. With the improved loop vectorization for Native Image, the differences in those code shapes are gone, allowing the compiler to vectorize more loops for faster execution. 
* Improved logging of the novel optimization compiler phase: unified interface to log and dump (for example, via JSON) optimization decisions. Optimization phases should use `OptimizationLog` to log transformations. Read more in [OptimizationLog.md](https://github.com/oracle/graal/blob/master/compiler/docs/OptimizationLog.md) and [Profdiff.md](https://github.com/oracle/graal/blob/master/compiler/docs/Profdiff.md) to learn how to compare performed optimizations in hot compilations. 
* Open-sourced [Ideal Graph Visualizer (IGV)](https://www.graalvm.org/latest/tools/igv/) to make it easier for third-party compilers and language developers to use and contribute to it. See more [here](https://github.com/oracle/graal/issues/4998).

See more updates in the [changelog](https://github.com/oracle/graal/blob/master/compiler/CHANGELOG.md#version-2300).

### Native Image

#### Packaging and Platform Updates
* Native Image is now shipped as part of GraalVM for JDK 17, and no longer needs to be installed via `gu install native-image`. Read more [here](https://github.com/oracle/graal/pull/5995).
* Native Image now sets build environments on Windows automatically if it can find a Visual Studio installation in a known location. Therefore, running in an x64 Native Tools Command Prompt is no longer a requirement.
* Improved dynamic linking of AWT libraries on Linux. Static linking of AWT libraries on Linux has been a constant source of problems. Dynamic linking avoids the pitfalls of static linking at the expense of no longer having standalone binaries, which is a reasonable trade-off as shown by AWT support on Windows. The linker should no longer fail because of "multiple definitions of `jvm`", or crash at the linking step for an AWS/Swing application on Linux.
* Jipher JCE, a Java Cryptography Architecture (JCA) provider implemented on top of OpenSSL 3.0 FIPS, now supports GraalVM Native Image. It is recommended to enable Jipher with Native Image in contexts where only FIPS-allowed algorithms should be used. See the [documentation](../../docs/security/JipherJCE.md) to get started.

#### New Features
* Introduced a new feature: building a native executable from a self-contained _bundle_ on demand. The new option `--bundle-create=<imagename>.nib` creates a _&lt;imagename&gt;.nib_ file (a build bundle) and the _launch.output_ directory alongside a native executable. The bundle file, _&lt;imagename&gt;.nib_, is a regular JAR file that contains all information required to build a native executable (or a native shared library). In contrast to regular `native-image` building, this mode of operation takes only a single <i>*.nib</i> file as an input. At any time later, if the same version of GraalVM is used, the executable can be rebuilt with:
```bash
native-image --bundle-apply=.../path/to/launch.nib
```
It will rebuild the native executable with the same image arguments, environment variables, system properties, classpath, and module-path options as in the initial build. It is a safe and reliable solution to encapsulate all the input required for building into a single file. Learn more in the [Native Image Bundles reference manual](https://www.graalvm.org/latest/reference-manual/native-image/overview/Bundles/).
* Improved the memory footprint of the Native Image build process. The builder now takes available memory into account to reduce memory pressure when many other processes are running on the same machine. It also consumes less memory in many cases and is therefore also less likely to fail due to out-of-memory errors. At the same time, the memory limit was raised from 14GB to 32GB.
* Native Image now targets x86-64-v3 architecture by default on AMD64 and provides a new `-march` option to specify target compatibility. Use `-march=compatibility` for best compatibility or `-march=native` for best performance if a native executable is deployed on the same machine or on a machine with the same CPU features. To list all available machine types, use `-march=list`.
* Improved reporting of missing metadata in Native Image by throwing special exceptions. Native Image does not distinguish between missing reachability metadata and exceptions that were thrown by the Reflection API. For example, the `ClassNotFoundException` that is thrown when a class is not on the classpath, or when the metadata for a class is not present. Now Native Image users can catch metadata exceptions and debug their programs using the option `-XX:ExitOnMissingMetadata` to guarantee that all metadata entries are correct. Read more [here](https://github.com/oracle/graal/issues/5171). This is an experimental feature and is not enabled by default.
* Introduced safe composition of Reflection and Resources metadata in Native Image. For example, reflective methods such as `java.lang.Class#getDeclaredMethodsreturn` are based on the reachability of other reflective elements. Adding new metadata makes more elements reachable and can change the program functionality. Thanks to the safe composition of metadata optimization, the `native-image` builder now ensures that every reflective call on `java.lang.Class` requires a metadata entry. Read more [here](https://github.com/oracle/graal/issues/5173).
* Disallowed the `--initialize-at-build-time` option without arguments. As a temporary workaround, the `-H:+AllowDeprecatedInitializeAllClassesAtBuildTime` option turns this error into a warning.
* Added an experimental RISC-V mode for Native Image through the LLVM backend. Read more in this [blog post](https://medium.com/graalvm/graalvm-native-image-meets-risc-v-899be38eddd9).
* Improved Profile-Guided Optimizations (PGO) in Native Image (PGO is not available in GraalVM Community Edition):
    * Profile-guided optimizations have a new sampling profiler that collect call stacks periodically. Use the option `--pgo-sampling` to turn on the sampling profiler and collect call stacks. This data is then included in the _.iprof_ file. When the PGO-instrumented executable is built, the sampling profiler turned on by default (but can be turned off with the option `-H:-SamplingCollect`). To get good profiles and therefore good peak performance, you need to run relevant workloads and properly warm up the application.
    * Implemented the Context-Aware Inliner (CAI) optimization which specializes in sampling profiles in the "hot" code, and invests more optimization effort into hot-compilation units. When the optimized image is built for PGO, the Context-Aware Inliner is automatically turned on (but can be turned off with the option `-H:-AOTInliner`). The results are 2-7% smaller executable sizes, and increased peak performance.
    * Improved merging profiles and enabled pre-packaged profiles.
* Added Machine Learning (ML) based profile inference. When profiling is disabled, the Graal compiler in Native Image uses a pre-trained ML model to infer the profiles of the control split branches. Then, inferred profiles are used to perform the profile-guided optimizations. In some benchmarks such as Renaissance, Da Capo, and Da Capo con Scala, this optimization provides ~6% runtime speedup compared to the default Oracle GraalVM configuration. By running the native executable build with the ML profile inference, you can expect a slight binary size increase of 1%-2%.
This optimization is enabled by default in Oracle GraalVM (not available in GraalVM Community Edition). To disable it, use the following option: `-H:-MLProfileInference`.
* Native Image SBOMs now include a single SBOM component for runtime components. This component uses the `java.vm.version` property of the executable to identify the version and belongs to the new `graalvm-native-image` product.

#### Build Output Improvements
* The builder now can generate build reports that help you better understand the contents of your executables. Use `-H:+BuildReport` to try this new experimental feature.
* Improved reporting of internal errors to be more user-friendly. A clear message tells users how to proceed: inspect the error report and, if unable to resolve the problem, file an issue with the error report. Inspired by HotSpot, the default filename for error reports is _./svm\_err\_b\_&lt;timestamp&gt;\_pid&lt;pid&gt;.md_. This also adds a new option `-H:ErrorFile` to let you choose a different filename for error reports. See [#5414](https://github.com/oracle/graal/pull/5414).
* Adjusted the `native-image` build output to report types (primitives, classes, interfaces, and arrays) instead of classes and revise the output schema of `-H:BuildOutputJSONFile`.
* The output of the `native-image --version` command and various Java properties (for example, `java.vm.version`) are aligned with OpenJDK. To distinguish between GraalVM Community Edition, Oracle GraalVM, and GraalVM distributions from other vendors, refer to `java.vm.vendor`.

#### Debugging and Monitoring Experience Improvements
* Deprecated using the option `--enable-monitoring` without an argument. The option no longer defaults to `all`. Instead, always explicitly specify the list of monitoring features to be enabled, for example, `--enable-monitoring=heapdump,jfr,jvmstat`.
* Added the option `-XX:HeapDumpPath` to control where a heap dumps is created.
* Added more JFR events for application monitoring: `ExecutionSample`, `ObjectAllocationInNewTLAB`, and `JavaMonitorInflate`.
* Improved debugging on Windows: debug information now includes information about Java types. (Together with Red Hat.)
* Implemented the remote management over JMX to Native Image which can be enabled with the option `--enable-monitoring`, for example: `--enable-monitoring=jmxclient,jmxserver`. Read more [here](https://github.com/oracle/graal/issues/4732). The feature is experimental. (Together with Red Hat.)
* Enabled the JFR event streaming for Native Image. The feature is experimental. (Together with Red Hat.)

Find many more updates in the [Native Image changelog](https://github.com/oracle/graal/blob/master/substratevm/CHANGELOG.md#version-2300).

### JavaScript and Node.js

* Updated Node.js to version 18.14.1.
* Added `BigInteger` interoperability support. Note that foreign `BigIntegers` require an explicit type cast using the `BigInt` function to opt into JS `BigInt` semantics. The default semantics is to treat all foreign numbers like JavaScript `Number` values, regardless of the original value or type. Arithmetic operators perform an implicit lossy conversion to double. Comparison operators attempt to do a precise value comparison where possible. JavaScript `BigInt` values can now be converted to `java.math.BigInteger` host objects, although a target type mapping may still be necessary to ensure consistent type mapping if the target type is ambiguous or absent.
* Implemented several new [ECMAScript proposals](https://github.com/tc39/proposals) in the GraalVM JavaScript runtime: 
    * The [Iterator Helpers proposal](https://github.com/tc39/proposal-iterator-helpers). It is available behind the experimental option `--js.iterator-helpers`.
    * The [ShadowRealm API proposal](https://github.com/tc39/proposal-shadowrealm). It is available behind the experimental option `--js.shadow-realm`.
    * The [Symbols as WeakMap keys proposal](https://github.com/tc39/proposal-symbols-as-weakmap-keys). It is available in ECMAScript staging mode, ()`--js.ecmascript-version=staging`).
    * The [`ArrayBuffer.prototype.transfer` and friends proposal](https://github.com/tc39/proposal-arraybuffer-transfer). It is available in ECMAScript staging mode (`--js.ecmascript-version=staging`).
    * The [Change Array by copy proposal](https://github.com/tc39/proposal-change-array-by-copy). It is available in ECMAScript staging mode (`--js.ecmascript-version=staging`).

Find more updates in the [project changelog](https://github.com/oracle/graaljs/blob/master/CHANGELOG.md#version-2300).

### Polyglot Embedding

* This is the first release that supports running untrusted applications in a code sandbox. The sandbox policy [`Context.Builder#sandbox(SandboxPolicy)`](https://www.graalvm.org/sdk/javadoc/org/graalvm/polyglot/SandboxPolicy.html) with four different levels of sandboxing, `ISOLATED`, `UNTRUSTED`, `TRUSTED`, and `CONSTRAINED`, was implemented to enable users to establish a security boundary between a host application and guest code. The policy is set by passing it to the `Engine.Builder#sandbox(SandboxPolicy)` or `Context.Builder#sandbox(SandboxPolicy)` builder method. A host code can execute untrusted guest code using, for example, the [UNTRUSTED](https://www.graalvm.org/sdk/javadoc/org/graalvm/polyglot/SandboxPolicy.html#UNTRUSTED) policy. Host code can also execute multiple mutually distrusting instances of guest code that will be protected from one another. Learn more in the [polyglot sandboxing guide](https://www.graalvm.org/security-guide/polyglot-sandbox/). Code sandboxing is currently only supported for JavaScript. The `SandboxPolicy.ISOLATED` and `SandboxPolicy.UNTRUSTED` policies are not available in GraalVM Community Edition.
* Related to the code sandbox implementation, a new option `TraceLimits` was added to measure a guest application's resource consumption and obtain realistic sandbox parameters.
* Added the `IOAccess` API: the IO access configuration of a polyglot context. The IO access configuration determines how a guest language can access the host IO. The new `IOAccess` class provides a predefined configuration to disable host IO access, or to enable full host IO access. A custom configuration can be created using an `IOAccess` builder.
* Added `java.lang.BigInteger` to the Polyglot Value API. By default, all host values of the type `java.lang.BigInteger` are now interpreted as number values (`Value.isNumber()`), unlike before. In order to restore the old behavior, set `HostAccess.Builder.allowBigIntegerNumberAccess(boolean)` to `false`. Note that the language support for interpreting numbers that do not fit into long values may vary. Some languages, such as JavaScript, may require explicit conversions of host big integers. Other languages, such as Ruby or Python, can use big integers without explicit conversion. The same applies to values passed across guest languages. See #[2737](https://github.com/oracle/graal/issues/2737). 
* Added automatic copying of language resources for embedding Truffle languages in Native Image. The documentation is available [here](https://www.graalvm.org/latest/reference-manual/embed-languages/#build-native-executables-from-polyglot-applications).

A full list of changes is available in the [changelog](https://github.com/oracle/graal/blob/master/sdk/CHANGELOG.md#version-2300).

### Truffle Language and Tool Implementations

* Implemented several new features for Truffle DSL to improve performance. In particular, a new annotation called `@GenerateInline` was introduced which allows Truffle nodes to be object-inlined automatically. Object-inlined Truffle nodes become singletons and therefore reduce memory footprint. This works analogously to `@GenerateCached` and `@GenerateUncached`, which generate a cached or uncached node version. Please [see the documentation](https://github.com/oracle/graal/blob/master/truffle/docs/DSLNodeObjectInlining.md) for further details.

Other updates contributing to performance improvements are:
* Updated Truffle DSL nodes no longer require the node lock during specialization, resulting in improved first execution performance. CAS-style inline cache updates are now used to avoid deadlocks when calling `CallTarget.call(...)` in guards. Inline caches continue to guarantee no duplicate values and are not affected by race conditions. Language implementations should be aware that the reduced contention may reveal other thread-safety issues in the language.
* Improved Truffle DSL node memory footprint by merging generated fields for state and excluding bit sets and improving specialization data class generation to consider activation probability. Specializations should be ordered by activation probability for optimal results.
* Improved memory footprint by automatically inlining cached parameter values of enum types into the state bitset.
* Truffle DSL now emits many more warnings for recommendations. For example, it emits warnings for inlining opportunities, cached sharing or when a cache initializer should be designated as `@NeverDefault`. To ease migration work, new ways to suppress the warnings temporarily for a Java package were added. For a list of possible warnings and further usage instructions, [see the documentation](https://github.com/oracle/graal/blob/master/truffle/docs/DSLWarnings.md).
* Unclosed polyglot engines are no longer closed automatically on VM shutdown. They die with the VM. As a result, `TruffleInstrument#onDispose` is not called for active instruments on unclosed engines in the event of VM shutdown. In case an instrument is supposed to do some specific action before its disposal, for example, print some kind of summary, it should be done in `TruffleInstrument#onFinalize`.
* Implemented the policies to control the restriction of code sandboxing. By default, languages and instruments support just the `TRUSTED` sandbox policy. 
    - If a language wants to target a more restrictive sandbox policy, it must:
        - Specify the most strict sandbox policy it satisfies using `TruffleLanguage.Registration#sandbox()`.
        - For each option, the language must specify the most restrictive sandbox policy in which the option can be used via `Option#sandbox()`. By default, options have a `TRUSTED` sandbox policy.
        - If a language needs additional validation, it can use `TruffleLanguage.Env#getSandboxPolicy()` to obtain the current context sandbox policy.
    - If an instrument wants to target a more restrictive sandbox policy, it must:
        - Specify the most strict sandbox policy it satisfies using `TruffleInstrument.Registration#sandbox()`.
        - For each option, the instrument must specify the most restrictive sandbox policy in which the option can be used via `Option#sandbox()`. By default, options have a `TRUSTED` sandbox policy.
        - If an instrument needs additional validation, it can use `TruffleInstrument.Env#getSandboxPolicy()` to obtain the engine's sandbox policy.

Find many more updates in the [Truffle changelog](https://github.com/oracle/graal/blob/master/truffle/CHANGELOG.md#version-2300).

### Java on Truffle (Espresso)

New features:
* The [Truffle InteropLibrary `has/getMetaParents` API](https://www.graalvm.org/truffle/javadoc/com/oracle/truffle/api/interop/InteropLibrary.html#getMetaParents-java.lang.Object-) is now fully implemented.
* Enabled foreign `Instant`, `TimeZone`, `Time`, `Date`, `Duration` when calling `espresso` via interop.

Improvements:
* Enabled calling overloaded and Varargs methods through interop.
* Improved interoperability with foreign exceptions. A stack trace is now available and type mapping can be used to explicitly map exceptions.

### Python

Performance Improvements:

* Added a new implementation of the [Python C API interface](https://www.graalvm.org/python/docs/#interoperability) that uses fully native execution by default. This improves performance and compatibility with some extensions that spend a lot of time in native code (such as SciPy, PyTorch, ...) but can have negative effects on workloads that frequently cross the Python/native boundary. There are new options to control how extensions are built and run: `python.NativeModules` and `python.UseSystemToolchain`. The new default is to use the host system's toolchain for building extensions rather than the LLVM toolchain that ships with GraalVM and to run all modules natively. A new launcher (`graalpy-lt`) is available to get the old behavior, which can be useful for debugging.
* The performance numbers we report on the [website](https://www.graalvm.org/python/) are now based on results from the community's [`pyperformance` benchmark suite](https://pyperformance.readthedocs.io/), measuring GraalPy geomean speedup over CPython and Jython. This makes it easier to compare and reproduce our results.

Platform Updates:

* Implemented building and running basic GraalPy workloads on Windows. This enables Windows users to build and use GraalPy, especially for embedding into Java.
* Added GraalPy plugin for [Virtualenv](https://virtualenv.pypa.io/en/latest/) as a builtin module, so that creating virtual environments with `virtualenv` on GraalPy works out of the box. 
* Updated the builtin `venv` module to create virtual environments with symlinks instead of generated shell scripts that are delegated to the base GraalPy.

Compatibility Improvements:

* Updated language version and the standard library to 3.10.8, making it compatible with more recent modules and packages.
* Updated the distribution layout of GraalPy to match CPython's. This reduces the number of patches needed for various build systems to discover GraalPy's library locations.
* Updated `numpy` and `pandas` versions.
* Implemented `scipy` and `scikit_learn` with `ginstall`. 

A full list of updates can be found in the [project changelog](https://github.com/oracle/graalpython/blob/master/CHANGELOG.md#version-2300).

### Ruby

New features:

* Updated to Ruby 3.1.3.
* Foreign big integers are now supported and work with all `Numeric` operators.

Performance:

* Made the system `libyaml` for `psych` to be used which improves warmup when parsing YAML. This means `libyaml` is now a dependency. See [how to install LibYAML](https://github.com/oracle/truffleruby/blob/master/doc/user/installing-libyaml.md).
* Marking of native structures wrapped in objects is now done on the C call exit to reduce memory overhead.
* Optimized splitting (copying) of call targets by implementing `cloneUninitialized()`.
* `Process.pid` is now cached per process like `$$`.
* Fixed repeated deoptimizations for methods building an `Array` which is growing over multiple calls at a given call site.

Bug fixes:

* Fixed `spawn(..., fd => fd)` on macOS, it did not work due to a macOS bug.
* Fixed `rb_gc_register_address()`/`rb_global_variable()` to read the latest value (see [#2721](https://github.com/oracle/truffleruby/issues/2721), [#2734](https://github.com/oracle/truffleruby/issues/2734)).

A full list of changes is available in the [project changelog](https://github.com/oracle/truffleruby/blob/master/CHANGELOG.md#2300).

### LLVM

* Updated the LLVM toolchain to version 15.0.6.
* Update `musl libc` to version 1.2.3.
* Implemented `long double` (128 bit floating point) on the Linux AArch64 architecture.

### WebAssembly

* Added experimental debugging for DWARFv4. This enables debugging of C, C++, and Rust applications.
* Added experimental support for Memory64. The feature can be enabled with the option `--wasm.Memory64=true`.
* Implemented the [Bulk-Memory](https://github.com/WebAssembly/bulk-memory-operations) and [Reference-Types](https://github.com/WebAssembly/reference-types) proposal. They can be disabled with the option `--wasm.BulkMemoryAndRefTypes`.