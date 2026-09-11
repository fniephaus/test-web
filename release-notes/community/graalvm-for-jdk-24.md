---
layout: toc_content_ecosystem
title: GraalVM for JDK 24
link_title: GraalVM for JDK 24
permalink: "/release-notes/JDK_24/"
toc_group: release-notes
---

# GraalVM for JDK 24.0.2
(2025-07-15)

This is the July 2025 Oracle Critical Patch Update (CPU) for GraalVM Community Edition for JDK 24.
It is based on the OpenJDK CPU and includes all the OpenJDK security fixes released as part of that CPU, platform updates, and some GraalVM bug fixes.
It is a full distribution and supersedes the previous release of GraalVM Community Edition for JDK 24.

* Updated the OpenJDK release on which GraalVM Community Edition is built to **24.0.2+11**. See the [OpenJDK 24 Updates](https://jdk.java.net/java-se-ri/24).
* Version compatibility:
  * Truffle languages and other components version **24.2.2** are designed for use with **GraalVM for JDK 24.0.2**.
* Graal compiler
  * Prevented vectorization of reads with usages both inside and outside the loop.
  * Added proper handling of nested frame states in loop vectorization.
  * Used DWORD comparisons for search values in `AMD64ArrayIndexOfOp`.
  * Invalidated profiling information in `VectorGuardTest#emptyLoopWithDeoptExit`.
  * Reverted load conversion in `SimdStamp.readConstant`.
* Native Image
  * Fixed a bug in the JFR type repository.
  * Added handling of `metadata/component` in the Build Report's SBOM components list.
  * Updated the SBOM to use identical values for the `bom-ref` and `ref` fields.
  * Corrected class names in heap dumps.
  * Applied various fixes for system properties and locales, including:
    * Fix for `SystemPropertiesSupport`
    * Fix for locale initialization crashes
    * Allowing `StaticProperty.<clinit>` to execute before system properties are fully initialized
  * Unified `SBOMProducers` and added a fallback mechanism for standalone mode.
  * Removed unnecessary parallel stream processing for classpath entries.
  * Validated reachable objects before propagating them.
  * Fixed a bug for class-level SBOMs on Windows.
  * Fixed JFR-related `UnsatisfiedLinkErrors`.
  * Fixed `RecurringCallbackTests_testManyMonitorOps`.
* GraalJS
  * Improved JavaScript exception message.
  * Modified `ExportValueNode.doTruffleObject()` to exclude `SafeIntegers`.
  * Corrected `Array.prototype.flat()` to avoid producing a foreign array.
* GraalWasm
  * Prevented `WasmCallStubNode` from being cast to `WasmDirectCallNode`.
  * Added missing Truffle Safepoint poll in the bytecode interpreter loop.
* Espresso
  * Fixed the JDWP frames command when a thread has no frames.
  * Fixed a performance regression in `Polyglot.castWithGenerics`.
  * Added test coverage for Espresso interop reading of foreign elements.
* GraalPy
  * Made storing `NO_VALUE` in an attribute remove the key-value pair.
  * Added support for `ormsgpack` and prepared upstreaming some changes.
  * Reverted breaking ABI changes in `graalpy242` wheels.
* Truffle framework
  * Reduced the number of threads for sandbox limit checking and ensured they are stopped when no active contexts remain.
  * Update JCodings to version 1.0.63.
* TRegex
  * Fixed the `GenerateDFAImmediately` option to free the NFA matcher.


# GraalVM for JDK 24.0.1
(2025-04-15)

This is the April 2025 Oracle Critical Patch Update (CPU) for GraalVM Community Edition for JDK 24.
It is based on the OpenJDK CPU and includes all the OpenJDK security fixes released as part of that CPU, platform updates, and some GraalVM bug fixes.
It is a full distribution and supersedes the previous release of GraalVM Community Edition for JDK 24.

* Updated the OpenJDK release on which GraalVM Community Edition is built to **24.0.1+9**. See the [OpenJDK 24 Updates](https://jdk.java.net/24/release-notes).
* Version compatibility:
  * [Truffle languages and other components](https://docs.oracle.com/en/graalvm/support-roadmap.html) version **24.2.1** are designed for use with **GraalVM for JDK 24.0.1**.
* Graal compiler
  * Removed unqualified exports from `jdk.graal.compiler`.
  * Moved resetting of `rethrowExceptions` to creating jump targets.
  * Configured the maximum Eden size for `LibGraalCollectionPolicy`.
  * `AMD64ArrayIndexOfOp`: Fixed a short jump across unknown alignment.
  * `EnterpriseReadElimination`: Fixed handling of `ObjectClone`.
  * Emit additional reinterpret when generating float CAS from node matching rules.
* Native Image
  * Adopted [JDK-8345266](https://bugs.openjdk.org/browse/JDK-8345266): imported the new `MonitorEnterWaitOOME` virtual thread test in JDK.
  * Implemented the use of the correct acquisition count in `acquireOnOOME`.
  * `AMD64ArrayIndexOfOp`: Fixed a short jump across unknown alignment.
  * Marked certain constant loads as not rematerializable to the stack.
  * `EnterpriseReadElimination`: Fixed handling of `ObjectClone`.
  * Strip fields from Maven-generated SBOMs so that only the fields defined by Native Image are kept.
  * Prevent absent hashcode computation split across safepoint checks.
  * Ensure tje `bom-ref` field is kept for all SBOM components.
* GraalJS
  * Fixed compilation failure in `ImportMetaNode`.
  * Implemented clearing away Wasm memory when `WasmInstance` is out of scope.
  * Set the `CONSTRAINED` sandbox policy for the `js.webassembly` option.
  * Made the option `js.text-encoding` stable and allowed in `SandboxPolicy.CONSTRAINED`.
  * Fixed `ClassCastException` in super property access.
* GraalWasm
  * Fixed a compilation bailout in `WasmFunctionInstance` [InteropLibrary](https://www.graalvm.org/truffle/javadoc/com/oracle/truffle/api/interop/InteropLibrary.html).
  * Avoid rereading code entries of already instantiated Wasm modules.
  * Set the `CONSTRAINED` sandbox policy for the `js.webassembly` option.
* GraalPy
  * Added several fixes for [PyMuPDF](https://github.com/pymupdf/PyMuPDF).
* TruffleRuby
  * Updated to Ruby 3.3.7.
* TRegex
  * Added multiple fixes for look-behind merging across main expression boundary.
* Truffle framework
  * Fixed out-of-bounds read in `AMD64CodepointIndexToByteIndexOp`.
  * Fixed boolean boxing elimination in combination with short-circuits could lead to deopt loops.
  * Fixed `TruffleSafepoint.poll(...)` must not fail if performed on unrelated threads while thread local actions are performed on a different thread.
  * Fixed when a return type compatibility check can lead to void specializations being filtered.

## GraalVM for JDK 24
(2025-03-18)

* [Platform and Distributions](#platform-and-distributions)
* [Availability of JDK 24 Features](#availability-of-jdk-24-features)
* [Graal Compiler](#graal-compiler)
* [Native Image](#native-image)
* [Polyglot Runtime](#polyglot-runtime)
* [GraalJS](#graaljs)
* [GraalPy](#graalpy)
* [GraalWasm](#graalwasm)
* [Espresso](#espresso)
* [TruffleRuby](#truffleruby)
* [Truffle Language Implementation Framework](#truffle-language-implementation-framework)

### Platform and Distributions

* Released **Oracle GraalVM for JDK 24** based on Oracle JDK 24. See [Java SE 24 Release Notes](https://www.oracle.com/java/technologies/javase/24-relnote-issues.html).
* Released **GraalVM Community Edition for JDK 24** based on OpenJDK 24. See [OpenJDK 24 Updates](https://jdk.java.net/24/).
* Version compatibility:
    * GraalVM for JDK 24 is compatible with [Graal Languages and other components](https://www.graalvm.org/jdk24/reference-manual/languages) version **24.2.0**.

### Features

* [450: Compact Object Headers (Experimental)](https://openjdk.org/jeps/450)
* [472: Prepare to Restrict the Use of JNI](https://openjdk.org/jeps/472)
* [475: Late Barrier Expansion for G1](https://openjdk.org/jeps/475)
* [478: Key Derivation Function API (Preview)](https://openjdk.org/jeps/478)
* [479: Remove the Windows 32-bit x86](https://openjdk.org/jeps/479)
* [484: Class-File API](https://openjdk.org/jeps/484)
* [485: Stream Gatherers](https://openjdk.org/jeps/485)
* [486: Permanently Disable the Security Manager](https://openjdk.org/jeps/486)
* [487: Scoped Values (Fourth Preview)](https://openjdk.org/jeps/487)
* [488: Primitive Types in Patterns, instanceof, and switch (Second Preview)](https://openjdk.org/jeps/488)
* [489:	Vector API (Ninth Incubator)](https://openjdk.org/jeps/489)
* [490: ZGC: Remove the Non-Generational Mode](https://openjdk.org/jeps/490)
* [491: Synchronize Virtual Threads without Pinning](https://openjdk.org/jeps/491)
* [492: Flexible Constructor Bodies (Third Preview)](https://openjdk.org/jeps/492)
* [493: Linking Run-Time Images without JMODs](https://openjdk.org/jeps/493)
* [494: Module Import Declarations (Second Preview)](https://openjdk.org/jeps/494)
* [495:	Simple Source Files and Instance Main Methods (Fourth Preview)](https://openjdk.org/jeps/495)
* [496: Quantum-Resistant Module-Lattice-Based Key Encapsulation Mechanism](https://openjdk.org/jeps/496)
* [497: Quantum-Resistant Module-Lattice-Based Digital Signature Algorithm](https://openjdk.org/jeps/497)
* [498: Warn upon Use of Memory-Access Methods in sun.misc.Unsafe](https://openjdk.org/jeps/498)
* [499: Structured Concurrency (Fourth Preview)](https://openjdk.org/jeps/499)
* [501: Deprecate the 32-bit x86 Port for Removal](https://openjdk.org/jeps/501)

### Graal Compiler

* The default number of JVMCI threads is now the same as of C2 threads (`-XX:JVMCINativeLibraryThreadFraction=0.66`). This benefits program warmup but could increase the maximum RSS. Setting `-XX:JVMCINativeLibraryThreadFraction` to a smaller value will result in smaller maximum RSS but potentially longer warmup. (See [JDK-8337493](https://bugs.openjdk.org/browse/JDK-8337493).)
* Display a deprecation warning upon the first use of the legacy `graal.` prefix. This warning will be upgraded to an error in GraalVM in JDK 26 or later.

### Native Image

#### Improvements and New Features

* In this release, a new generation of machine learning-powered profile inference has been introduced—the **Graal Neural Network (GNN) static profiler**—resulting in a 7.9% peak performance improvement observed across a wide range of microservices benchmarks. To enable this optimization, pass the `-O3` option to Native Image. This feature is only available in Oracle GraalVM. Learn more in the [documentation](https://www.graalvm.org/jdk24/reference-manual/native-image/optimizations-and-performance/).
* Introduced SkipFlow: a new experimental extension to the Native Image static analysis that tracks primitive values and evaluates branching conditions dynamically during the analysis process. SkipFlow can provide up to a 4% reduction in binary size without any additional impact on build time. The feature is available in GraalVM for JDK 24, but is not enabled by default. Enable and test it using the following options: `-H:+TrackPrimitiveValues` and `-H:+UsePredicates`. This enhancement is the result of a research collaboration. Find the paper [here](https://dl.acm.org/doi/10.1145/3696443.3708932) to read more.
* Added experimental support for running premain methods of Java agents at runtime. At build time, specify the premain classes using the `-H:PremainClasses` option. At runtime, provide the premain runtime options along with the main class arguments in the format `-XXpremain:<class>:<options>`. (See [#8988](https://github.com/oracle/graal/pull/8988).)
* Enhanced experimental Vector API support in Native Image AOT compilation, now on par with Graal JIT. To enable Vector API optimizations when building native images, use the `--add-modules jdk.incubator.vector` and `-H:+VectorAPISupport` options. (See [#10285](https://github.com/oracle/graal/issues/10285).) Improvements include a greater number of optimized Vector API operations. The following operations are now efficiently compiled to SIMD code, where supported by the target hardware:
  * Operations on Vector API masks
  * Masked Vector API loads and stores
  * General Vector API rearrange operations
  * Vector API loads/stores to and from memory segments
* Optimized the [Foreign Function and Memory API (FFM) in Native Image](https://www.graalvm.org/jdk24/reference-manual/native-image/native-code-interoperability/foreign-interface) by introducing specialized upcalls for direct method handles.
* Enhanced the Software Bill of Materials (SBOM) support in GraalVM Native Image to improve security and provide deeper insights into application dependencies:
  * Class-level metadata inclusion: You can now include class-level metadata to the SBOM components in a native image using the `--enable-sbom=class-level,export` option. This information can be useful for advanced vulnerability scanning and better understanding of the image contents.
  * Dependency tree generation: The SBOM now includes a detailed dependency tree derived from the static analysis. This feature provides a hierarchical view of component dependencies within the native executable.
  * Improved accuracy of the SBOM which is critical for vulnerability scanning: The GAV coordinates are now more accurate by extending parsing and handling of manifest files and integrating with the [Native Image Maven plugin](https://graalvm.github.io/native-build-tools/latest/maven-plugin.html), reducing false-negatives. Shaded and Fat JARs are now better handled to prune redundant components and reduce false positives in vulnerability scanning.

  Only available in Oracle GraalVM. Read more in the [documentation](https://www.graalvm.org/jdk24/security-guide/native-image/sbom).
* Include serialization JSON reachability metadata as part of the reflection metadata by introducing the `serializable` flag for reflection entries.
* Preserve the origin of a resource included in a native image. The information is included in the Build Report by default, or can be produced by passing the `-H:+GenerateEmbeddedResourcesFile` option.
* Added support for `GetStringUTFLengthAsLong` in JNI. (See [JDK-8328877](https://bugs.openjdk.org/browse/JDK-8328877).)
* The length of the printed stack trace when using `-XX:MissingRegistrationReportingMode=Warn` can now be set with `-XX:MissingRegistrationWarnContextLines=` and its default length is now 8.
* `ActiveProcessorCount` is now required to be set during isolate or VM creation.
* Optimized the `ForkJoinPool.commonPool()` builder method to consistently respect the value set by `NativeImageOptions.NumberOfThreads`.
* Added `DuringSetupAccess.registerObjectReachabilityHandler` to allow registering a callback that is executed when an object of a specified type is marked as reachable during heap scanning.

#### Platform Compatibility

* Native Image now targets `armv8.1-a` by default on AArch64. Pass `-march=compatibility` at build time for best compatibility or `-march=native` for best performance if the native executable is deployed on the same machine or a machine with the same CPU features. To list all available machine types, use `-march=list`.

* Added support for Java module system-based service loading. For example, defining the following in a _module-info.java_ file:

  ```java
  module Foo {
      provides MyService with org.example.MyServiceImpl;
  }
  ```

#### Debugging and Monitoring Improvements

* Added experimental support for `jcmd` on Linux and macOS. Use the `--enable-monitoring=jcmd` option to build a native image with `jcmd` enabled. See the [documentation](https://www.graalvm.org/jdk24/reference-manual/native-image/debugging-and-diagnostics/jcmd/) for more information.
* Added a possibility to debug native executables with a Python helper script, _gdb-debughelpers.py_, based on the [GDB Python API](https://sourceware.org/gdb/current/onlinedocs/gdb/Python.html). See the [documentation](https://www.graalvm.org/jdk24/reference-manual/native-image/guides/debug-native-image-process-with-python-helper-script/) to learn more.
* Updated debug info from DWARF4 to DWARF5 and now store type information in DWARF type units. Switching to DWARF5 reduces the size of debugging information by 30%.
* Added support for emitting the Windows x64 unwind information. This enables stack walking in native tooling such as debuggers and profilers.

#### Deprecated Functionality

* Removed the `customTargetConstructorClass` field from the serialization JSON metadata. All possible constructors are now registered by default when registering a type for serialization. `RuntimeSerialization.registerWithTargetConstructorClass` is now deprecated.
* Display a deprecation warning upon the first use of the legacy `graal.` prefix. This warning will be upgraded to an error in GraalVM in JDK 26 or later.

### Polyglot Runtime

* Language and instrument resources are now automatically included when embedding a Graal Language in a native image. By default, a separate resources folder is no longer created next to the image. Read more in the [Embedding Languages guide](https://www.graalvm.org/jdk24/reference-manual/embed-languages/).
* Starting in GraalVM for JDK 24, users must configure native access privileges to the `java` executable in order to avoid warnings from being printed by the JDK. For usages of the module-path, pass the `--enable-native-access=org.graalvm.truffle` option, and for class-path usages, pass the `--enable-native-access=ALL-UNNAMED` option to resolve the new warning. Note that Truffle automatically forwards the native access capability to all loaded languages and tools, therefore no further configuration is required. If the native access is denied by the user with `--illegal-native-access=deny`, then loading the optimizing runtime will fail and the fallback runtime will be used. More information can be found in the integrity-by-default [JEP 472](https://openjdk.org/jeps/472).
* `Context` and `Engine` is now automatically closed when no longer strongly referenced. A reachable `Value` or `PolyglotException` will keep the associated `Context` reachable. Additionally, the `Context` remains reachable when explicitly entered or if there is an active polyglot thread within it. The `Engine` remains reachable when there is a strongly reachable `Language`, `Instrument`, or `Context` instance. However, it is still recommended not to rely on garbage collection for closing. Instead, use the try-with-resources pattern for explicit context and engine management. For more information, refer to the [Automatic Close on GC documentation](https://github.com/oracle/graal/blob/master/truffle/docs/CloseOnGc.md).
* Added the ability to use `Value#as(byte[].class)` to copy the contents of a guest language byte buffer `(Value#hasBufferElements())` to a new byte array. The new functionality has precedence over accessing the guest object as array `(Value#hasArrayElements())` if both ways are available.
* Added support for creation of strings from raw byte arrays and native memory using `Value.fromByteBasedString(...)` and `Value.fromNativeString(...)`. `Value.StringEncoding` must be provided.

Find a complete list of updates in the [changelog](https://github.com/oracle/graal/blob/master/sdk/CHANGELOG.md#version-2420).

### GraalJS

* Implemented several ECMAScript proposals:
  * [Error.isError](https://github.com/tc39/proposal-is-error), available in ECMAScript staging mode (`--js.ecmascript-version=staging`).
  * [Math.sumPrecise](https://github.com/tc39/proposal-math-sum),  available in ECMAScript staging mode (`--js.ecmascript-version=staging`).
  * [Atomics.pause](https://github.com/tc39/proposal-atomics-microwait), available in ECMAScript staging mode (`--js.ecmascript-version=staging`).
  * [Promise.try](https://github.com/tc39/proposal-promise-try), available in ECMAScript staging mode (--js.ecmascript-version=staging).
  * [Uint8Array to/from base64 and hex](https://github.com/tc39/proposal-arraybuffer-base64), available in ECMAScript staging mode (`--js.ecmascript-version=staging`).
  * [RegExp.escape](https://github.com/tc39/proposal-regex-escaping), available in ECMAScript staging mode (`--js.ecmascript-version=staging`).
  * [Iterator Sequencing](https://github.com/tc39/proposal-iterator-sequencing), available in ECMAScript staging mode (`--js.ecmascript-version=staging`).
  * [Source Phase Imports](https://github.com/tc39/proposal-source-phase-imports), available behind the experimental option `--js.source-phase-imports`.
  * [Regular Expression Pattern Modifiers](https://github.com/tc39/proposal-regexp-modifiers), available by default.
* Implemented the `TextDecoder` and `TextEncoder` APIs of the [WHATWG Encoding Standard](https://encoding.spec.whatwg.org/). They are available behind the experimental option `--js.text-encoding`.
* Made options `js.load`, `js.print`, `js.graal-builtin`, and `js.locale` stable and allowed in the `SandboxPolicy.UNTRUSTED` mode.
* GraalJS now supports [WebAssembly/ES module integration](https://github.com/WebAssembly/esm-integration) that allows `.wasm` modules to be loaded via `import` statements. The option`js.webassembly` is now stable.

Find a complete list of updates in the [project changelog](https://github.com/oracle/graaljs/blob/master/CHANGELOG.md#version-2420).

### GraalPy

#### New Features

* Released the GraalPy Gradle Plugin for [embedding of Python packages into Java](https://github.com/graalvm/graal-languages-demos/tree/main/graalpy/graalpy-javase-guide#42-adding-packages).
* Added the experimental `python.IsolateNativeModules` option to allow loading native extensions multiple times in different contexts. See the [documentation](https://github.com/oracle/graalpython/blob/master/docs/user/Native-Extensions.md) for more information.
* Foreign objects are now given a Python class corresponding to their interop traits. Foreign lists now inherit from Python `list`, foreign dictionaries from `dict`, foreign strings from `str`, foreign iterators from `iterator`, foreign exceptions from `BaseException`, foreign numbers from `polyglot.ForeignNumber`, foreign booleans from `polyglot.ForeignBoolean`, and foreign null values from `NoneType`. This means all Python methods of these types are available on the corresponding foreign objects, which behave as close as possible as if they were Python objects.
When calling a method on a foreign object in Python code, Python methods are now prioritized over foreign members.
Also added `polyglot.register_interop_type` and `@polyglot.interop_type` to define custom Python methods for a given foreign class ot type. See the [documentation](https://github.com/oracle/graalpython/blob/master/docs/user/Interoperability.md#interacting-with-foreign-objects-from-python-scripts) for more information.

#### Java Embeddings Improvements

* Introduced new types: `KeywordArguments` and `PositionalArguments` in the GraalPy Embedding library (`org.graalvm.python:python-embedding`), to support directly passing keyword and positional arguments from Java to Python.
* Deprecated the `org.graalvm.python.embedding.util` package and added new equivalents to `org.graalvm.python.embedding`.
* Maven and Gradle plugins do not embed Python home into the generated virtual filesystem. Instead, the handling of language home for any Graal Language, including GraalPy, for the GraalVM Native Image build can be controlled by new Native Image options `+H:IncludeLanguageResources` and `+H:CopyLanguageResources`. By default, the whole Python home is embedded into the native executable. In the case of JVM deployment, the language home is embedded in the [GraalPy artifacts at Maven Central](https://mvnrepository.com/artifact/org.graalvm.python).

Find a complete list of updates in the [project changelog](https://github.com/oracle/graalpython/blob/master/CHANGELOG.md#version-2420).

### GraalWasm

* WebAssembly modules now can be loaded in JavaScript via `import` statements. GraalJS now supports [WebAssembly/ES module integration](https://github.com/WebAssembly/esm-integration). Read more [here](#add-link-to-examples-or-docs).
* Implemented the [Relaxed SIMD proposal](https://github.com/WebAssembly/relaxed-simd). This feature can be enabled with the option `--wasm.RelaxedSIMD`.
* Deprecated the `--wasm.AsyncParsingBinarySize` and `--wasm.AsyncParsingStackSize` options. These options no longer have any effect and will be removed in a future release.

Find a complete list of updates in the [project changelog](https://github.com/oracle/graal/blob/master/wasm/CHANGELOG.md#version-2420).

### Espresso

* Improvements to [Espresso Continuation API](https://github.com/oracle/graal/blob/master/espresso/docs/continuations.md): continuation suspension now clears slots based on liveness analysis. This ensures the set of captured variables is predictable and deterministic.
* Added support for automatically using generic type parameters for incoming host objects, to allow more seamless communication between host and Espresso contexts.
* Custom type converters now always take precedence over built-in converters when passing objects from the host to the embedded Espresso context.
* Espresso's [hash interop](https://www.graalvm.org/truffle/javadoc/com/oracle/truffle/api/interop/InteropLibrary.html#hasHashEntries(java.lang.Object)) implementation now throws an unsupported operation exception when attempting to modify an unmodifiable guest map.
* `Polyglot.cast()` now applies custom type converters and interface type mappings, same as `Polyglot.castWithGenerics()`.
* The `<ProcessReferences>` builtin no longer hangs when multi-threading is disabled.

Find a complete list of updates in the [project changelog](https://github.com/oracle/graal/blob/master/espresso/CHANGELOG.md#version-2420).

### TruffleRuby

* Updated to Ruby 3.3.5.
* `Polyglot::ForeignException` now inherits from `StandardError` instead of `Exception`.
* Added support for OpenSSL versions 1.1 through 3.4, with preference given to OpenSSL 3.0.x, followed by 3.x, and 1.1 (End of Life). Resolved a compilation issue with OpenSSL 3.4.
* Improved the speedup of some C extensions like `sqlite3`, `trilogy`, and `json` by 2 to 3 times by using the [Panama NFI backend](https://openjdk.org/projects/panama/) for faster upcalls in the JVM mode.
* Optimized encoding negotiation for ASCII-compatible encodings.

Find a complete list of updates and bug fixes in the [TruffleRuby changelog](https://github.com/oracle/truffleruby/blob/master/CHANGELOG.md#2420).

### Truffle Language Implementation Framework

* Added the experimental [Bytecode DSL](https://www.graalvm.org/truffle/javadoc/com/oracle/truffle/api/bytecode/package-summary.html), a new framework for implementing bytecode interpreters. The Bytecode DSL automatically generates a complete bytecode interpreter from a set of user-specified operations. The generated interpreter defines all the necessary components of a bytecode interpreter, including an instruction set, a bytecode generator, and an optimizing interpreter. Bytecode DSL interpreters are designed to improve footprint and interpreter speed over AST interpreters without compromising peak performance. Bytecode DSL interpreters support a variety of features, including tiered interpretation, bytecode quickening, and boxing elimination, continuations, and serialization. They also integrate with existing Truffle tooling for instrumentation and debugging. See the [Introduction to Bytecode DSL](https://github.com/oracle/graal/blob/master/truffle/docs/bytecode_dsl/BytecodeDSL.md) to get started, or check the [user guide](https://github.com/oracle/graal/blob/master/truffle/docs/bytecode_dsl/UserGuide.md) for more information. The Bytecode DSL is experimental in this release.
* Java Native access for [JEP 472: Prepare to Restrict the Use of JNI](https://openjdk.org/jeps/472) is now automatically provided for all languages and tools by Truffle.
* Added the `TruffleLanguage.Env.getHostLanguage()` method returning the host language info. This allows languages to lookup the top scope of the host language using `Env.getScopeInternal(LanguageInfo)`.
* Added the `@Bind.DefaultExpression` annotation. Default expressions allow you to omit an explicit expression when declaring a `@Bind` parameter (the default expression for the parameter's type is used).
* Added `RootNode.findInstrumentableCallNode(...)` that allows resolving the instrumentation location given a call node, frame, and bytecode index. This allows to store instrumentable nodes in a side data structure for bytecode interpreters. Also the `TruffleStackTraceElement.getInstrumentableLocation()` and `FrameInstance.getInstrumentableCallNode()` methods were added to access the resolved locations. Tools using the Truffle instrumentation framework are encouraged to use these APIs instead for the purpose of accessing node locations.

Find a complete list of updates in the [Truffle changelog](https://github.com/oracle/graal/blob/master/truffle/CHANGELOG.md#version-2420).