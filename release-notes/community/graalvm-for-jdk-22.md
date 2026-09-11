---
layout: toc_content_ecosystem
title: GraalVM for JDK 22
link_title: GraalVM for JDK 22
permalink: "/release-notes/JDK_22/"
toc_group: release-notes
---

# GraalVM for JDK 22.0.2
(2024-07-16)

This is the July 2024 Critical Patch Update (CPU) for GraalVM Community Edition for JDK 22.
It is based on the OpenJDK CPU and includes all the OpenJDK security fixes released as part of that CPU, platform updates, and some GraalVM bug fixes.
It is a full distribution and supersedes the previous release of GraalVM Community Edition for JDK 22.

* Updated the OpenJDK release on which GraalVM Community Edition is built to **22.0.2+9**. See [OpenJDK 22 Updates](https://jdk.java.net/java-se-ri/22).
* Version compatibility:
    * [Truffle languages and other components](https://www.graalvm.org/jdk22/reference-manual/languages/) version **24.0.2** are designed for use with **GraalVM for JDK 22.0.2**.
* Graal compiler:
    * Added epsilon to more floating-point probability comparisons.
    * Fixed SIMD reinterpret stamp folding.
    * Improved Strip mining optimization to not strip mine loops with `CaptureStateBegin` successors.
    * Improved Counted strip mining optimization to use correct inner-to-outer state.
    * Unsigned loops that need an overflow to terminate must not be counted.    
    * Properly implemented `isConstantStride` for masked negate strides.
* Native Image:
    * Fixed values reported in the `GCHeapSummary` JFR event.
    * Disabled failing tests for the FFM API (project Panama).
    * Improved reference processing to be more robust, especially against OOME during tear-down.
    * Removed `OpaqueValueNodes` at the end of low tier.
    * Implemented skipping a G1 argument parsing if `-H:-ParseRuntimeOptions` is specified.
    * Added partial support for physical memory usage and JFR tests for periodic native events.
    * Recomputed `Buffer.address` field for array-based buffers in the image heap.
    * Added tests to verify the conversion function.
    * Added the runtime module layer tests. 
    * Removed `getpwuid` in favor of `getpwuid_r`.
    * Fixed data limitation for breakdown charts in build reports.
    * Added a few `OutOfMemoryError`-related fixes.
    * Fixed a consistency issue in `HeapImplMemoryMXBean.getHeapMemoryUsage()`.
    * Made stack pointer aligned while in `deoptStub`.
    * Changed CCharPointer from "char" to "signed char".
* Truffle framework:
    * Improved the error message when a polyglot implementation is missing.
    * Disabled `LoggingTest#testDisableLoggersSingleContext`.
    * Improved the `ContextPolicyTest#testOptionDescriptorContextReuse` method to be more robust.
    * Fixed the issue when `com.oracle.truffle.polyglot.InternalResourceRoots$Root.path()` could not be invoked because `this.owningRoot` was null.
    * Fixed the issue when `SpeculationReason` could not be re-used after the speculate call.
* Java on Truffle (Espresso):
    * Fixed the JDWP method invocation.
    * Fixed type converter combination for foreign exceptions and custom type converters.
    * Fixed stepping into intrinsified Java methods in JDWP.
    * Added profiling to Espresso method resolution from interop.
    * Added support for converting foreign object to a non-mapped interface.
* JavaScript:
    * Upgraded the underlying Node.js to version 18.20.2.
    * Changed the `esm-eval-returns-exports` option be stable and usable in the sandbox mode.
* Tooling
    * Updated CPUSampler to not log interrupts if the sampler is already closed, and added various other CPUSampler fixes.

# GraalVM for JDK 22.0.1
(2024-04-16)

This is the April 2024 Critical Patch Update (CPU) for GraalVM Community Edition for JDK 22.
It is based on the corresponding OpenJDK CPU and includes all the OpenJDK security fixes released as part of that CPU, platform updates, and some bug fixes.
It is a full distribution and supersedes the previous release of GraalVM Community Edition for JDK 22.

* Updated the OpenJDK release on which GraalVM Community Edition is built to **22.0.1+8**. See [OpenJDK 22 Updates](https://jdk.java.net/22/).
* Version compatibility:
    * [Truffle languages and other components](https://www.graalvm.org/jdk22/reference-manual/languages/) version **24.0.1** are designed for use with **GraalVM for JDK 22.0.1**.
* Graal compiler:
    * Removed SIMD vectorization.
    * Ensure guards are attached to `MoveGuardsUpwards` to respect a DOM tree.
    * Run `OptimisticGuards` as cleanup before `OptimisticAliasingAnalysis`.
    * Fixed a simplification of always-deoptimize `FixedGuard`.
    * Added a guard against deletion in `PiNode.canonical` recursion.
* Native Image:
    * Register the virtual thread group unconditionally.
    * Updated `-g` to include all information for profiling. Fix the problem with `objcopy` strip command.
    * Fixed a deadlock in `IsolateAwareTruffleCompiler.tearDownIsolateOnShutdown`.
    * Report an error if building a static executable without `musl libc`.
    * Consider stack slot sizes when limiting number of parameters in SBOutlining.
    * Documented `-O`, `-march`, and build artifacts.
* Truffle framework:
    * Added `InsertGuardFencesPhase` into runtime compilation phases.
* Java on Truffle (Espresso):
    * Fixed `NullPointerException` in JDWP when debugger asks for local variable table.
    * Fixed single stepping in Espresso JDWP when stepping within code that is not yet loaded.
* JavaScript:
    * Upgraded the underlying Node.js to version 18.19.1.
    * Added a check to the `instanceof` operator whether the left side is a foreign object.

# GraalVM for JDK 22
(2024-03-19)

* [Platform and Distributions](#platform-and-distributions)
* [Availability of JDK 22 Features](#availability-of-jdk-22-features)
* [Java and Compiler](#java-and-compiler)
* [Native Image](#native-image)
* [Polyglot Runtime](#polyglot-runtime)
* [Polyglot Embedding](#polyglot-embedding)
* [JavaScript and Node.js](#javascript-and-nodejs)
* [Java on Truffle](#java-on-truffle-espresso)
* [Python](#python)
* [Ruby](#ruby)
* [LLVM](#llvm)
* [Truffle Language and Tool Implementations](#truffle-language-and-tool-implementations)

### Platform and Distributions

* Released **GraalVM Community Edition for JDK 22** based on OpenJDK 22. See [OpenJDK 22 Updates](https://jdk.java.net/22/).
* Released **Oracle GraalVM for JDK 22** based on Oracle JDK 22. See [Java SE 22 Release Notes](https://www.oracle.com/java/technologies/javase/22-relnote-issues.html).
* Version compatibility:
    * GraalVM for JDK 22 is compatible with [Truffle languages and other components](https://www.graalvm.org/jdk22/reference-manual/languages) version **24.0.0**.

### Availability of [JDK 22 Features](https://openjdk.org/projects/jdk/22/)

| JEP | Title | Graal JIT | Native Image |
|:---:|:------|:---:|:---:|
| [423](https://openjdk.org/jeps/423) | Region Pinning for G1 | ✅ | ✅ *Garbage collection already enabled during JNI critical regions* |
| [447](https://openjdk.org/jeps/447) | Statements before super(...) (Preview) | ✅ | ✅ |
| [454](https://openjdk.org/jeps/454) | Foreign Function & Memory API | ✅ | 🧩 [#8113](https://github.com/oracle/graal/issues/8113) |
| [456](https://openjdk.org/jeps/456) | Unnamed Variables & Patterns | ✅ | ✅ |
| [457](https://openjdk.org/jeps/457) | Class-File API (Preview) | ✅ | ✅ |
| [458](https://openjdk.org/jeps/458) | Launch Multi-File Source-Code Programs | ✅ | ℹ️ |
| [459](https://openjdk.org/jeps/459) | String Templates (Second Preview) | ✅ | ✅ |
| [460](https://openjdk.org/jeps/460) | Vector API (Seventh Incubator) | ✅ *full optimization in progress* | 🏗️ |
| [461](https://openjdk.org/jeps/461) | Stream Gatherers (Preview) | ✅ | ✅ |
| [462](https://openjdk.org/jeps/462) | Structured Concurrency (Second Preview) | ✅ | ✅ |
| [463](https://openjdk.org/jeps/463) | Implicitly Declared Classes and Instance Main Methods (Second Preview) | ✅ | ✅ |
| [464](https://openjdk.org/jeps/464) | Scoped Values (Second Preview) | ✅ | ✅ |
| [439](https://openjdk.org/jeps/439) | Generational ZGC (from [JDK 21](https://openjdk.org/projects/jdk/21/)) | 🏗️ [#8117](https://github.com/oracle/graal/issues/8117) | ℹ️ |

✅ fully available
🧩 partially available
🏗️ not available yet, in progress
ℹ️ not applicable

### Java and Compiler

* The Graal module has been renamed from `jdk.internal.vm.compiler` to `jdk.graal.compiler`. Likewise, the compiler packages moved into the `jdk.graal.compiler` namespace. This renaming was done in preparation for [Project Galahad](https://openjdk.org/projects/galahad/), and to establish the namespace `jdk.graal` for Graal subprojects. See [#7621](https://github.com/oracle/graal/pull/7621).
* The Graal options now use the `jdk.graal.` prefix, for example, `-Djdk.graal.PrintCompilation=true`. The legacy `graal.` prefix is deprecated but still supported (for example, `-Dgraal.PrintCompilation=true`). 
* Added `-Djdk.graal.PrintIntrinsics` to log the intrinsics used by Graal in the current runtime.

Find more updates in the [changelog](https://github.com/oracle/graal/blob/master/compiler/CHANGELOG.md#graalvm-for-jdk-22-internal-version-2400).

### Native Image

#### New Features

* Added experimental support for the Foreign Function & Memory API (part of "Project Panama", [JEP 454](https://openjdk.org/jeps/454)) on the x64 architecture. 
The API must be explicitly enabled with `-H:+ForeignAPISupport` (requires also `-H:+UnlockExperimentalVMOptions`). 
Currently, it includes support for foreign memory functionality and foreign functions downcalls. 
Modules that perform "restricted" native operations must be specified using the `--enable-native-access` option. 
Check [Foreign Function and Memory API in Native Image](https://github.com/oracle/graal/blob/master/docs/reference-manual/native-image/ForeignInterface.md) for a more detailed overview of the FFM API support.
* The `--strict-image-heap` option is now enabled by default, so it can be removed from the argument list. It allows all classes to be used at build time but also requires types of all objects in the heap to be explicitly marked for build-time initialization.
* Added support for the `NATIVE_IMAGE_OPTIONS` environment variable, which allows users and tools to pass additional arguments via the environment. Similar to `JAVA_TOOL_OPTIONS`, the value of the environment variable is prepended to the options supplied to `native-image`. See [GitHub issue #4650](https://github.com/oracle/graal/issues/4650).

#### Improvements

* Improved the Native Image agent tracking calls mechanism: the agent now tracks calls to `ClassLoader.findSystemClass`, `ObjectInputStream.resolveClass`, and `Bundles.of`, and registers resource bundles as bundle name-locale pairs.
* Updated the Lambda class name format in Native Image to `CapturingClass$$Lambda/0xstableHash` to be consistent with the JDK name format.
* Improved intrinsification of method handles. This especially improves the performance of `equals` and `hashCode` methods for Java records, which use now intrinsified method handles.
* Methods, fields, and constructors of the Java Object class, primitive classes, and array classes are now registered by default for reflection.
* Improved reporting missing metadata in Native Image by throwing special exceptions (experimental). The users can catch metadata exceptions early and debug related issues using the `-H:ThrowMissingRegistrationErrors=<package-prefix>` option (or `-H:ThrowMissingRegistrationErrors` for all packages).
* Improved Native Image to correctly rethrow build-time linkage errors at run time for registered reflection queries. This prevents the same queries return empty results without throwing an exception. See [GitHub issue #6691](https://github.com/oracle/graal/issues/6691).
* `System#setSecurityManager` now throws a `java.lang.UnsupportedOperationException` by default, instead of a VM error in cases where it is expected to throw an exception. This prevents from halting program execution. If the property `java.security.manager` is set to anything, but disallow at program startup, this function will throw `java.lang.SecurityException` according to the Java specification.

#### Debugging and Monitoring Improvements

* Added support for the following JFR events: `AllocationRequiringGC`, `SystemGC`, and `ThreadAllocationStatistics`. See GitHub pull requests [#7263](https://github.com/oracle/graal/pull/7263) and [#7294](https://github.com/oracle/graal/pull/7294). (Together with Red Hat.)
* Provided the API option for creating thread dumps `--enable-monitoring=threaddump`. The option `-H:±DumpThreadStacksOnSignal` is now deprecated and marked for removal.

#### Deprecated and Removed Functionality

* The options `ParseOnce`, `ParseOnceJIT`, and `InlineBeforeAnalysis` are deprecated and no longer have any effect.
* The legacy `build` option was removed from `native-image-agent`.

### Polyglot Runtime

* Removed support for legacy `<language-id>.home` system property. Only `org.graalvm.language.<language-id>.home` will be used.

### Polyglot Embedding

* Added the ability to use `Value#as(Collection.class)` to map guest language arrays, (`Value#hasArrayElements()`), to the Java Collection interface in order to access the array elements without copying the guest language array. Set [GitHub issue #260](https://github.com/oracle/graalpython/issues/260).
* Implemented mapping of interop buffers to `byte[]` in a host application, which included:
    * Added `Value#readBuffer(long, byte[], int, int)` to enable bulk reads of buffers into byte arrays.
    * Custom implementations of `ByteSequence`, same as the values returned by `ByteSequence.create(byte[])`, are now interpreted by guest languages as buffers.
    * Added the ability to use `Value#as(ByteSequence.class)` to map guest language byte buffers `(Value#hasBufferElements())` to the read-only ByteSequence interface in order to access the bytes without copying the guest language buffer.
* Deprecated the `FileSystems#allowLanguageHomeAccess()` method and introduced `FileSystem#allowInternalResourceAccess()` as a replacement. To ensure compatibility, both methods now provide support for language homes and internal resources.

Find a complete list of updates in the [changelog](https://github.com/oracle/graal/blob/master/sdk/CHANGELOG.md#version-2400).

### JavaScript and Node.js

* Updated Node.js to version 18.18.2.
* Implemented the [WebAssembly threads proposal](https://github.com/WebAssembly/threads).
Implemented the [Promise.withResolvers proposal](https://github.com/tc39/proposal-promise-with-resolvers). It is available in the ECMAScript staging mode (enabled with `--js.ecmascript-version=staging`).
* Moved the implementation of [Async Iterator Helpers proposal](https://github.com/tc39/proposal-async-iterator-helpers) (that was split out from Iterator Helpers proposal) behind the experimental option `--js.async-iterator-helpers`.
* Implemented the [Well-Formed Unicode Strings proposal](https://github.com/tc39/proposal-is-usv-string). It is available in the ECMAScript staging mode (enabled with `--js.ecmascript-version=staging`).
* Implemented [the JSON.parse source text access proposal](https://github.com/tc39/proposal-json-parse-with-source). It is available in the ECMAScript staging mode (enabled with `--js.ecmascript-version=staging`).
* The WebAssembly support in Node.js was enabled by default. It can be disabled using the experimental option `--js.webassembly=false`.
* Replaced the `--js.import-assertions` option with `--js.import-attributes` because the [corresponding Import Attributes proposal](https://github.com/tc39/proposal-import-attributes) migrated from the usage of assertions to the usage of attributes.

### Java on Truffle (Espresso)

* Added support for transparently converting common JDK exception types that flow from a host to an embedded Espresso context.
* Added support for transparently converting host primitive arrays to Espresso primitive arrays.
* Added support for foreign `BigInteger` when calling Espresso via the [Interop protocol](https://www.graalvm.org/truffle/javadoc/com/oracle/truffle/api/interop/InteropLibrary.html). It included also the adoption of `fitsInBigInteger` and `asBigInteger` Truffle interop messages.
* Added support for `removeArrayElement` interop messages for Espresso List objects.
* Added bringing overload-selection to parity with what is supported for calling methods when using a constructor via [Interop](https://www.graalvm.org/truffle/javadoc/com/oracle/truffle/api/interop/InteropLibrary.html).
* Java on Truffle (Espresso) can now run on a JDK 22 host. Supported guest JDK versions are 8, 11, 17, and 21.

### Python

#### New Features

* Switched to using the system toolchain instead of the GraalVM LLVM runtime (Sulong). This reduces the footprint in the default configuration where C extensions are run natively.
* Added a new option `python.InitialLocale` to change the default locale. If not set, then Java's `Locale#getDefault` is used.
* The `multiprocessing` module now creates new processes by default, using the `spawn` method. The formerly default method that uses threads and multiple Truffle contexts can be selected using `multiprocessing.set_start_method('graalpy')`.
* We now provide a collection of GitHub Actions scripts to build popular native extensions on GraalPy. 
This enables the Python users to build native applications, in a reproducible way, with the correct dependencies on GitHub, and download artifacts from there. See [Scripts to build wheels for GraalPy](https://github.com/oracle/graalpython/blob/master/scripts/wheelbuilder/README.md) to get started.
* Added the GraalPy integration with [jBang](https://www.jbang.dev/). You can try it out with the following command:
    ```bash
    jbang hello@oracle/graalpython/release/graal-vm/24.0 "print('Hello GraalPy!')"
    ```

#### Compatibility
 
* Updated to Python 3.10.13. It inlines the security and bug fixes from 3.10.8 to 3.10.13.
* Improved Windows compatibility: added support for installing packages with native extensions on Windows. Simple packages like `ujson` or `kiwisolver` will now work when installed from `venv` inside a Visual Studio command prompt. This means that users can build native applications on Windows.
*  Included the GraalPy C API revision in the ABI tag for the Python `wheels` packaging format. This avoids accidentally using incompatible binaries when using snapshots.
* Expanded support for the following modules: `llvmlite`, `pydantic-core`, `catboost`, `ray`, `tensorflow`, `tensorflow-io`, `readme-renderer`, `safetensors`, `keras`, `pybind11`, `protbuf`, `grpcio`, `PyO3`, `cryptography`, `bcrypt`, `cramjam`, `libcst`, `orjson`, `rpds_py`.

#### Interoperability

* Improved the `polyglot` module by adding the API to redefine Truffle interop messages for external user-defined types. For more details see the [Truffle Interoperability Extension API](https://github.com/oracle/graalpython/blob/master/docs/user/Interoperability.md).
* Interop null values are now treated as identical, not only equal to Python's `None`. This means that when `java.type("java.lang.Object[]")(1)[0]` is `None`, it will return `True`.
* Enabled the `allowHostSocketAccess` configuration in embeddings. This means sockets can now be disabled independently of other IO operations.
* Foreign BigIntegers are now supported and work with all Numeric operators.
           
Find a complete list of updates in the [project changelog](https://github.com/oracle/graalpython/blob/master/CHANGELOG.md#version-2400).

### Ruby

#### New Features

* C/C++ extensions are now compiled using the system toolchain and executed natively instead of using the GraalVM LLVM runtime (Sulong). This leads to faster startup, no warmup, better compatibility, smaller distribution, and faster installation for C/C++ extensions ([#3118](https://github.com/oracle/truffleruby/pull/3118)).
* Added full support for the Ruby 3.2 and Ruby 3.3 syntax by adopting the [Prism parser](https://github.com/ruby/prism) ([#3117](https://github.com/oracle/truffleruby/pull/3117), [#3039](https://github.com/oracle/truffleruby/pull/3039)).
* Added support for pattern matching ([#3332](https://github.com/oracle/truffleruby/pull/3332), [#2683](https://github.com/oracle/truffleruby/pull/2683)).
* Implemented most of Ruby 3.2 features ([#3039](https://github.com/oracle/truffleruby/pull/3039)).

#### Performance

* Optimized calls with `ruby2_keywords` forwarding by deciding it per call site instead of per callee.

There were multiple bug fixes and compatibility improvements in this release, which you can find in the [TruffleRuby release notes](https://github.com/oracle/truffleruby/releases/tag/graal-24.0.0).
 
### LLVM

* Made `ld64.lld` the default linker on macOS instead of a system linker. This fixes compatibility problems with the LLVM toolchain wrappers and Xcode 15 on macOS platforms.

### Truffle Language and Tool Implementations

* The Truffle languages and tools implementations are now loaded exclusively using the context class loader if it is set and Truffle is found there. If the context class loader is not set or Truffle is not found, then the system class loader is used instead. Context class loaders that do not delegate to the system class loader are commonly used to implement hot-reload functionality.
* Added the `--engine.AssertProbes` option, which asserts that enter and return are always called in pairs on `ProbeNode`, and verifies the correct behavior of wrapper nodes. Java asserts need to be turned on for this option to have an effect.
* Added a new performance warning to Truffle DSL when mixing shared and non-shared inline nodes/profiles triggers the slow path in inlining support code.
* Added the system property `-Dtruffle.UseFallbackRuntime=true`. This property is preferred over the usage of `-Dtruffle.TruffleRuntime=com.oracle.truffle.api.impl.DefaultTruffleRuntime`.
* Added `InteropLibrary#readBuffer(long, byte[], int, int)` to enable bulk reads of buffers into byte arrays.
* Implemented the `onYield()` and `onResume()` instrumentation events in the debugger stepping logic.

Find a complete list of updates in the [Truffle changelog](https://github.com/oracle/graal/blob/master/truffle/CHANGELOG.md#version-2400).