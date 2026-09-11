---
layout: toc_content_ecosystem
title: GraalVM 25
link_title: GraalVM 25
permalink: "/release-notes/JDK_25/"
toc_group: release-notes
---

# GraalVM Community Edition 25.0.2
(2026-01-20)

This is the January 2026 Oracle Critical Patch Update (CPU) for GraalVM Community Edition.

* Updated GraalVM Community Edition 25 to **25.0.2**.
* Updated the Oracle JDK release on which Oracle GraalVM is built to **25.0.2+10**. See [Java SE 25 Release Notes](https://www.oracle.com/java/technologies/javase/25-relnote-issues.html){:target="_blank"}.
* Support for macOS x64 has been removed. Version 25.0.1 was the last release that supported this hardware architecture. GraalVM now only supports macOS on AArch64 (Apple Silicon).
* Version compatibility:
  * GraalVM Community Edition 25.0.2 is compatible with [Graal Languages and other components](https://www.graalvm.org/jdk25/reference-manual/languages) version **25.0.2**.
* Graal compiler
  * Enhanced boxing snippets with profile information to improve primitive caching performance and reduce boxing overhead.
  * Fixed hash collisions in `CompilationResultBuilder.buildLabelOffsets()` to improve Tier 1 compilation times on AArch64.
  * Fixed potential crash with `DynamicObjectLibrary.removeKey` to prevent type confusion during property deletion.
  * Fixed loop vectorization miscompilation that produced incorrect results due to improper handling of delayed phi patterns, where phi nodes used values from previous iterations.
  * Fixed `OptimisticGuardsPhase` to properly remove redundant guards and prevent incorrect deoptimizations when reverting `OptimisticMemoryEdge`.
  * Fixed frame access to use opaque placeholder values when deleting a `VirtualFrameAccessorNode`.
* Native Image
  * Fixed JFR memory leak in Java event TLBs.
  * Fixed `native-image-configure` to properly register types from JNI sections as JNI-accessed.
  * Fixed a segfault in `ReleasePrimitiveArrayCritical`.
  * Added verification to ensure that objects in the young generation do not have a remembered set bit for improved garbage collection integrity.
  * Applied `java_util_prefs` substitution when `java.prefs` module is present.
  * Fixed in-place `copySwap` in `JavaMemoryUtil`.
  * Fixed the reachability metadata schema and included it in the GraalVM distribution.
  * Fixed constructor accessor checks for improved reflection handling.
  * Enabled FFM API without libc dependency for broader platform compatibility.
  * Improved error messages for better user experience.
  * Fixed Win32 API error handling in `WindowsVMSemaphore`.
  * Enhanced native memory management to use `LibC.free()` when freeing memory allocated by libc or other native code.
  * Ensured Native Image SBOM feature uses a compatible XML parser.
  * Fixed dynamic collection policy to call `updateSizeParameters()` only when `DynamicCollectionPolicy` is used.
* GraalJS
  * Fixed converting values injected by Truffle instruments to types supported by GraalJS, preventing type errors when instruments inject unexpected interop values like `short`.
  * Fixed clearing temporary variables used during destructuring assignment that prevented proper garbage collection of referenced objects.
* GraalPy
  * Fixed loading delvewheel wheels on Windows, resolving issues where NumPy wheels from graalvm.org could not be imported.
  * Made native slot wrappers context-specific.
  * Fixed missing descriptor for `__hash__` in `__slots__` to properly support classes that declare `__hash__` as a slot attribute.
* Truffle framework
  * Fixed assertion statements with explicit checks that provide clearer error messages when operation arguments are mismatched.
  * Fixed `SubstrateEnterpriseOptimizedCallTarget` without return profile to prevent deopt loops.
  * Fixed overloaded method caching regression in `HostExecuteNode` that caused performance regression in host interop microbenchmarks (`interop-pointarray`, `interop-callmathmin`, `interop-callstringformat`).
  * Fixed incorrect offset handling in `FromJavaStringNode` for TruffleStrings.
  * Removed `DynamicThresholdsQueue` and optimized compilation thresholds scaling for better performance.
  * Fixed heap root computation to be thread safe for improved stability.

## GraalVM Community Edition 25.0.1
(2025-10-21)

This is the October 2025 Oracle Critical Patch Update (CPU) for GraalVM Community Edition.

* Updated GraalVM Community Edition 25 to **25.0.1**.
* Updated the Oracle JDK release on which Oracle GraalVM is built to **25.0.1+8**. See [Java SE 25 Release Notes](https://www.oracle.com/java/technologies/javase/25-relnote-issues.html).
* Version compatibility:
  * GraalVM Community Edition 25.0.1 is compatible with [Graal Languages and other components](https://www.graalvm.org/jdk25/reference-manual/languages) version **25.0.1**.
* Support for macOS x64 has been removed. Version 25.0.1 was the last release that supported this hardware architecture. GraalVM now only supports macOS on AArch64 (Apple Silicon).
* Graal compiler
  * Improved Merge Explode partial evaluation by eliminating `ProxyPlaceHolder` nodes for better performance.
  * Analyzed and optimized Tier 2 compile times on function 5311 for improved compilation performance.
  * Enhanced `LinearScan` lifetime analysis by compressing bitsets to reduce memory overhead.
  * Fixed handling of `StageFlag.VECTOR_API_EXPANSION` for proper Vector API support.
  * Added support for conditional invocation plugin in runtime compilation scenarios.
  * Fixed `HostInlining` to correctly mark dominators as `"inInterpreter"` when branches are never executed.
* Native Image
  * Improved array type handling in missing registration tests for better error reporting.
  * Corrected misleading help text for the `--future-defaults` option.
  * Enhanced crash log generation with additional diagnostic information including heap base alignment checks, isolated compilation support and status, compilation isolate details with main isolate ID, OS thread IDs and handles for all isolate threads, and image heap chunk information similar to G1 reporting.
  * Removed `AMD64.CPUFeature.HT` from build time CPU features.
  * Fixed `GlobalAtomicLong.address` reset to prevent runtime segmentation faults caused by uninitialized address values in the image heap.
  * Fixed pending JNI exception leak in `native-image-agent` for better resource management.
  * Enhanced exception handling to return `UNCAUGHT_EXCEPTION` for uncaught exceptions.
  * Fixed canonicalization of always-null guarded values.
  * Fixed rare race conditions for improved stability.
  * Optimized G1 `InitialRAMPercentage` to improve application startup time and memory usage.
  * Fixed `TruffleFeature` failure when blocklisting classes containing deleted methods.
  * Added support for conditional invocation plugin in runtime compilation scenarios.
* Truffle framework
  * Improved deoptimization cycle detection by ignoring deopt nodes with "None" action.
  * Improved Merge Explode partial evaluation by eliminating `ProxyPlaceHolder` nodes for better performance.
  * Fixed `TruffleFeature` failure when blocklisting classes containing deleted methods.
  * Reduced excessive process execution times by optimizing compilation wait handling.
  * Fixed`HostInlining` to correctly mark dominators as `"inInterpreter"` when branches are never executed.
* Espresso
  * Enhanced multiple context handling for improved isolation and resource management.
  * Re-enabled class modifiers redefinition tests for JDK 25 compatibility.
* GraalWasm
  * Added support for v128 values in polymorphic select instruction for better SIMD compatibility.
* TRegex
  * Added intrinsic for `TStringOps#runByteSwap` to improve string operation performance.

## GraalVM 25
(2025-09-16)

* [Platform and Distributions](#platform-and-distributions)
* [Availability of JDK 25 Features](#features)
* [Graal Compiler](#graal-compiler)
* [Native Image](#native-image)
* [GraalJS](#graaljs)
* [GraalPy](#graalpy)
* [GraalWasm](#graalwasm)
* [Espresso](#espresso)
* [Polyglot Runtime](#polyglot-runtime)
* [Truffle Framework](#truffle-language-implementation-framework)

### Platform and Distributions

* Released **Oracle GraalVM 25** based on Oracle JDK 25. See [Java SE 25 Release Notes](https://www.oracle.com/java/technologies/javase/25-relnote-issues.html){:target="_blank"}.
* Released **GraalVM Community Edition 25** based on OpenJDK 25. See [OpenJDK 25 Updates](https://jdk.java.net/25/){:target="_blank"}.
* * Oracle GraalVM is now available for Oracle Linux 10. Support for Oracle GraalVM on Oracle Linux 7 has ended. For setup instructions, see the [installation guide](https://docs.oracle.com/en/graalvm/jdk/25/docs/getting-started/oci/compute-instance/).
* Version compatibility:
    * Oracle GraalVM 25 is compatible with [Graal Languages and other components](https://www.graalvm.org/jdk25/reference-manual/languages) version **25.0.0**.

### Features

* [470: PEM Encodings of Cryptographic Objects (Preview)](https://openjdk.org/jeps/470)
* [502: Stable Values (Preview)](https://openjdk.org/jeps/502)
* [503: Remove the 32-bit x86 Port](https://openjdk.org/jeps/503)
* [505: Structured Concurrency (Fifth Preview)](https://openjdk.org/jeps/505)
* [506: Scoped Values](https://openjdk.org/jeps/506)
* [507: Primitive Types in Patterns, instanceof, and switch (Third Preview)](https://openjdk.org/jeps/507)
* [508: Vector API (Tenth Incubator)](https://openjdk.org/jeps/508)
* [509: JFR CPU-Time Profiling (Experimental)](https://openjdk.org/jeps/509)
* [510: Key Derivation Function API](https://openjdk.org/jeps/510)
* [511: Module Import Declarations](https://openjdk.org/jeps/511)
* [512: Compact Source Files and Instance Main Methods](https://openjdk.org/jeps/512)
* [513: Flexible Constructor Bodies](https://openjdk.org/jeps/513)
* [514: Ahead-of-Time Command-Line Ergonomics](https://openjdk.org/jeps/514)
* [515: Ahead-of-Time Method Profiling](https://openjdk.org/jeps/515)
* [518: JFR Cooperative Sampling](https://openjdk.org/jeps/518)
* [519: Compact Object Headers](https://openjdk.org/jeps/519)
* [520: JFR Method Timing & Tracing](https://openjdk.org/jeps/520)

### Graal Compiler

* Implemented initial optimization of Java Vector API ([JEP 338](https://openjdk.org/jeps/338){:target="_blank"}) operations. Load, store, basic arithmetic, reduce, compare, and blend operations are transformed to efficient machine instructions where possible. Coverage of more operations is planned for the future. This optimization is experimental and can be disabled by setting the `OptimizeVectorAPI` option to `false`. Vector API operations are supported both on JIT and when building native images.

### Native Image

#### Performance Improvements

* Enabled [Whole-Program Sparse Conditional Constant Propagation (WP-SCCP)](https://github.com/oracle/graal/pull/9821){:target="_blank"} by default, improving the precision of points-to analysis in Native Image. This optimization enhances static analysis accuracy and scalability, potentially reducing the size of the final native binary. Learn more about this optimization in [SkipFlow: Producing Smaller Executables with GraalVM](https://medium.com/graalvm/skipflow-producing-smaller-executables-with-graalvm-f18ca98279c2){:target="_blank"}.
* Refined the [Graal Neural Network (GraalNN) models](https://docs.oracle.com/en/graalvm/jdk/25/docs/reference-manual/native-image/optimizations-and-performance/#ml-powered-profile-inference-for-enhanced-performance) for control split profile inference by introducing two specialized variants: a more conservative model for `O2` and a more aggressive one for `O3`. These updates are expected to deliver performance improvements of 1–3% for both `O2` and `O3` optimization levels, as well as a binary size reduction of over 1% in `O2`.
The new GNN-based control split profile inference is enabled by default in `O3`. To enable it in `O2`, pass the option `-H:+MLProfileInferenceUseGNNModel`.
* Added an XGBoost-based static profiler for call count profile inference in Native Image. The model classifies methods as either cold or regular/hot, guiding optimizations and reducing binary size with minimal impact on runtime performance. To enable it, use the option: `-H:+MLCallCountProfileInference`. Not available in GraalVM Community Edition.
* Added the experimental option `-H:+RelativeCodePointers` to significantly reduce relocation entries in position-independent executables and shared libraries.

#### New Features

* Enhanced support for the Foreign Function & Memory (FFM) API ([JEP 454](https://openjdk.org/jeps/454){:target="_blank"}) in Native Image:
  * **Platform compatibility** – Enabled FFM API (“Panama”) support on macOS AArch64 and Linux AArch64.
  * Introduced a new syntax for configuring the FFM API.
  * Implemented `Arena.ofShared()` from the FFM API.
  * Added the Tracing agent support for applications using the FFM API. The agent generates the FFM configuration in the _reachability-metadata.json_ file. Additionally, support for FFM configurations has been added to the `native-image-configure` tool.
  * Added extensive [reference documentation](https://www.graalvm.org/jdk25/reference-manual/native-image/native-code-interoperability/ffm-api/) for FFM API support in Native Image.
* Implemented initial optimization support of Java Vector API [JEP 338](https://openjdk.org/jeps/338){:target="_blank"} operations in native images. To enable these optimizations, build native images with the `--add-modules jdk.incubator.vector` and `-H:+VectorAPISupport` options.
* Introduced `--future-defaults=[all|run-time-initialize-jdk|<options>|none]`, which enables options planned to become defaults in future releases. The enabled options are:
  * `run-time-initialize-jdk` – Shifts from build-time initialization of the JDK to runtime initialization for most components. This transition is gradual, with different JDK components becoming runtime initialized in each release. In this release, it enables `run-time-initialize-security-providers` and `run-time-initialize-file-system-providers`.
  If JDK classes are not stored in the image heap, this option should have no effect. If the option breaks your build, follow the suggestions in the error messages.
  * `complete-reflection-types` – Ensures that reflective registration of a type (via metadata files or the [Feature API](https://www.graalvm.org/25.0/javadoc/sdk/org/graalvm/nativeimage/hosted/Feature.html)) always includes all type metadata. All registered types now behave consistently with types defined in the _reachability-metadata.json_ file.
  * `run-time-initialize-security-providers` – Shifts from build-time initialization of security providers to runtime initialization. Unless `java.security.Provider`-related classes are stored in the image heap, this option should have no effect. If it breaks your build, follow the suggestions in the error messages. Run-time initialization of security providers helps reduce image heap size by avoiding unnecessary objects inclusion.
  * `run-time-initialize-file-system-providers` – Shifts from build-time initialization of `java.nio.file.spi.FileSystemProvider` to runtime initialization. Unless `FileSystemProvider`-related classes are stored in the image heap, this option should have no effect. If it breaks your build, follow the suggestions in the error messages.
* Enabled `--install-exit-handlers` by default for native executables and deprecated the option. If shared libraries were using this option, the same functionality can be restored by using the `-H:+InstallExitHandlers` host option.
* Recurring callback support is no longer enabled by default. To enable this feature, use the `-H:+SupportRecurringCallback` host option at image build time.
* Added the experimental option `ClassForNameRespectsClassLoader`, which makes `Class.forName(...)` respect the class loader hierarchy.

#### Improved Security

* Introduced **advanced obfuscation** for Native Image — an experimental Oracle GraalVM-only feature that applies symbol obfuscation to enhance protection against reverse engineering by renaming symbols in native images.
Advanced obfuscation affects user code and third party dependencies, but not JDK and GraalVM classes, or names required by reachability metadata, annotations, and proxies.
To enable the feature, pass `-H:AdvancedObfuscation=` to the `native-image` command.
Learn more in the [reference documentation](https://www.graalvm.org/jdk25/security-guide/native-image/obfuscation/).
* A [Software Bill of Materials (SBOM)](https://www.graalvm.org/jdk25/security-guide/native-image/sbom/) is now embedded by default in native images. To disable the SBOM from being embedded, pass the option `--enable-sbom=false`. (Not available in GraalVM Community Edition).

#### Simplified Metadata Configuration

* Added the experimental option `-H:Preserve` to instruct the `native-image` tool to keep entire packages, modules, or all classes on the classpath. For example, if you pass `-H:Preserve=package=<package_name>`, all of the classes in that package will be available in the native executable, even if static analysis could not discover them. The usage syntax is `-H:Preserve=[all|none|module=<module>|package=<package>|package=<package-wildcard>|path=<cp-entry>][,...]`. See the [example application](https://github.com/graalvm/graalvm-demos/tree/master/native-image/preserve-package) for this use case.
* JNI registration is now included as part of the `"reflection"` section in the _reachability-metadata.json_ file using the `"jniAccessible"` attribute. Registrations performed through the `"jni"` section of _reachability-metadata.json_ and through _jni-config.json_ will still be accepted and parsed correctly.
* Enabled lambda classes to be registered for reflection and serialization in the _reachability-metadata.json_ file. The format is detailed [here](https://github.com/oracle/graal/blob/master/docs/reference-manual/native-image/ReachabilityMetadata.md#reflection).
* Resource bundle registration is now included as part of the `"resources"` section in the _reachability-metadata.json_ file. When this is the case, the bundle name is specified using the `"bundle"` field. Find the examples in the [documentation](https://github.com/oracle/graal/blob/master/docs/reference-manual/native-image/ReachabilityMetadata.md#resource-bundles).
* Missing registration errors are now subclasses of `LinkageError`.
* Improved handling of invalid class names under `--exact-reachability-metadata`: Reflection and JNI queries now correctly throw the expected JDK exceptions without requiring metadata entries when the queried class name is clearly invalid.

#### Experimental Native Image Tracing Agent

* Added experimental support for a new Native Image Tracing Agent. Unlike the [existing tracing agent](https://www.graalvm.org/latest/reference-manual/native-image/metadata/AutomaticMetadataCollection/) (which observes application behavior on the JVM), the new agent operates in Native Image mode and is more closely aligned with Native Image semantics.
  * To use the new agent, build your application with `-H:Preserve=all` (which also enables `-H:+MetadataTracing`), and then run the executable with `-XX:TraceMetadata=path=<trace_output_directory>`.
  * The agent will trace the actual types, resources, and other elements required by Native Image, and generate reachability metadata. This metadata can then be used to re-build the application with only the required types and resources.

#### Platform Compatibility

* In containers and CI environments, the build process now uses 85% of system memory. Otherwise, it tries to only use available memory. If less than 8GB of memory are available, it falls back to 85% of system memory. The reason for the selected memory limit is now also shown in the build resources section of the build output.

#### Debugging and Monitoring Improvements

* Added support for the runtime debug info generation using the option `-H:+RuntimeDebugInfo`. It adds runtime debugging information into a native image for use with GDB.
* Added a JVM version check to the Native Image agent. The agent now aborts execution if the JVM major version does not match the version it was built with and issues a warning if the full JVM version differs.
* Added validation of hosted options passed to `native-image` before starting the build process. Unknown options are detected early, with suggestions provided to help fix them.
* Added the experimental `-H:+JDWP` option.

#### Deprecated Functionality

* Deprecated class-level metadata extraction using `native-image-inspect` and removed the `DumpMethodsData` option. Instead, use class-level SBOMs by passing `--enable-sbom=class-level,export` to the `native-image` builder. The default value of the `IncludeMethodData` option has been changed to `false`.
* Removed the sequential reachability handler. The only remaining variant is the concurrent reachability handler, which has been the default implementation since its introduction. Additionally, the `-H:-RunReachabilityHandlersConcurrently` option was removed, which had been deprecated in GraalVM for JDK 24.
* Removed the total number of loaded types, fields, and methods from the Native Image build output, deprecated these metrics in the build output schema, and removed already deprecated build output metrics.
* Jipher Java Cryptographic Service Provider (JCP) is no longer available as part of the **Oracle GraalVM** release, but can be downloaded separately from [Java Tools and Resources](https://www.oracle.com/java/technologies/downloads/tools/#Jipher). For more information, see the [Jipher JCP reference documentation](https://docs.oracle.com/en/java/java-components/jipher/10/jipher-user-guide/what-is-oracle-jipher.html).

### GraalJS

* Enabled ECMAScript 2025 mode by default.
* Made the option `js.text-encoding` stable and allowed in `SandboxPolicy.CONSTRAINED`.
* Enabled source phase imports from WebAssembly modules (`import source mod from "./mod.wasm"`) by default if the `js.webassembly` option is enabled, and the `js.source-phase-imports` option is not explicitly set to `false`.
* Implemented several ECMAScript proposals:
  * [Intl.DurationFormat](https://github.com/tc39/proposal-intl-duration-format){:target="_blank"}
  * [Deferring Module Evaluation](https://github.com/tc39/proposal-defer-import-eval){:target="_blank"}, available in ECMAScript staging mode (`--js.ecmascript-version=staging`)
  * [Upsert](https://github.com/tc39/proposal-upsert){:target="_blank"}, available in ECMAScript staging mode (`--js.ecmascript-version=staging`)
* Updated Node.js to version 22.17.1.

### GraalPy

#### Improvements and New Features

* Updated the Python standard library and core to version 3.12.8.
* The full-featured Python REPL is now available on GraalPy standalone builds for Windows.
* The `sys.implementation.version` call now returns the GraalPy version instead of the Python version it implements. Additionally, the GraalPy version is available as `sys.graalpy_version_info` for easier discovery, especially by users familiar with PyPy’s `sys.pypy_version_info`.
* The `GRAALPY_VERSION_NUM` C macro now includes the release level and serial number to fully conform to the `hexversion` format, without breaking existing version comparisons.
* The `dir(foreign_object)` call now returns both foreign methods and Python methods, whereas previously it returned only foreign methods.
* Added support for the `__name__`, `__doc__`, and `__text_signature__` attributes on foreign executables, enabling better integration with Python-side introspection. This is useful, for example, when using Java functional interfaces in place of Python functions—such as with LangChain’s `@tool` annotation that inspects underlying functions.
* Implemented `faulthandler.dump_traceback_later` to enhance support for testing frameworks that handle resilience to crashes.
* Added support for sharing Arrow arrays and tables between Java, PyArrow, and Pandas, reducing data copying when embedding these libraries into Java projects.
* Enabled FTS3, FTS4, FTS5, RTREE, and math function features in the bundled SQLite3 library.
* Added compatibility patches for several libraries and versions, including Torch 2.7.0, PyGObject 3.52.3, xmlschema 4.0.0, lxml (below 5.4.0), SciPy 1.15, jq 1.8.0, NumPy (below 2.3), ormsgpack (below 1.9.1), pandas 2.2.3, PyArrow 19.0, and PyMuPDF 1.25.4.

#### Removed Functionality

* Removed support for running C extensions as LLVM bitcode. This also removes the related options `python.UseSystemToolchain` and `python.NativeModules`. Isolation of native code when embedding GraalPy into Java projects is now provided by the Oracle GraalVM polyglot isolate feature, which can launch in a separate external sub-process by setting the `--engine.IsolateMode=external` option.
* Removed the built-in HPy module. HPy can now be installed and used from its upstream sources.

#### Platform Compatibility

* Fixed several issues affecting `cibuildwheel` on Windows to make it easier for Python projects to build and distribute native extensions for GraalPy on all supported platforms.
* The GraalPy Native standalone on Linux now uses the G1 garbage collector which is much faster.

### GraalWasm

* `Context.eval` now returns a compiled (but not yet instantiated) module object, rather than a module instance. To instantiate the module, call `newInstance()` on the returned module object. For example:
  ```java
  Context c = Context.create();
  Source wasmSource = Source.newBuilder(...).build();
  Value module = c.eval(wasmSource);
  Value instance = module.newInstance(); // prior to 25.0: c.eval(wasmSource)
  ```
  * This change allows a single compiled module to be instantiated multiple times and run independently within the same context. Previously, each module could only be instantiated once per context.
  * The `newInstance()` method optionally accepts an import object (similar to the WebAssembly JavaScript API), as well as other modules to link together.
  * To restore the previous behavior, pass the experimental option `--wasm.EvalReturnsInstance=true` to the builder.
  * Note that modules instantiated via `module.newInstance()` are not accessible through `context.getBindings("wasm")`, unlike modules instantiated directly using `context.eval` when the `--wasm.EvalReturnsInstance=true` option is used.
* Exports are no longer exposed as direct members of the module instance.
Instead, use the exports member of the module instance to access its exports. For example:
  ```java
  Value mainFunction = instance.getMember("exports").getMember("main"); // prior to 25.0: instance.getMember("main")
  ```
  This change aligns the API with the WebAssembly JavaScript API and makes it possible to introduce other members on the module instance without name clashes.
  For more details and migration examples, see the [GraalWasm Polyglot API Migration Guide](https://github.com/oracle/graal/blob/master/wasm/docs/user/GraalWasmAPIMigration.md) and the [project README](https://github.com/oracle/graal/blob/master/wasm/docs/user/README.md).
* Implemented support for editing primitive values during debugging. Fixed several debugger-related issues.
* Implemented the [WebAssembly SIMD proposal](https://github.com/WebAssembly/simd) using the JDK’s Vector API. This improves peak performance when running WebAssembly code that makes heavy use of SIMD instructions. The new implementation is always enabled in native images. On the JVM, it is opt-in and requires setting `--add-modules=jdk.incubator.vector`. Because the Vector API is incubating, enabling it will print the following warning to stderr:
  ```bash
  WARNING: Using incubator modules: jdk.incubator.vector
  ```

### Espresso

* Added support for guest Java version 25.
* Added experimental support for `-javaagent`. The support for `java` agents helps integrate with various IDEs, debuggers, and so on. It can also be enabled via the Polyglot API by setting the option `java.JavaAgent.$i` to `/path/to/jar=agent-options`, where `$i` starts at 0 and increments by 1 for each additional Java agent.
* Added the `org.graalvm.continuations.IdentityHashCodes` class, which provides utilities to restore identity hash codes. This can be used to improve deserialization of continuations.
* Introduced the `EnableAdvancedRedefinition` option, which controls whether features such as method or field addition/removal and class hierarchy changes are enabled. This option controls access to these capabilities for both JDWP and Java agents. Previously, this functionality was enabled by default for JDWP; in this release, it must now be explicitly turned on.
* Added experimental support for JVMCI, which can be enabled with the `java.EnableJVMCI` option.

### Polyglot Runtime

* All language and tool POMs artifacts are now OSS licensed. It means:
  * The "community" Maven artifacts (those with an artifact ID ending in `-community`) are now identical to their corresponding "non-community" artifacts.
  * All community language and tool POM artifacts have been deprecated.
  * The only exception is `org.graalvm.truffle:java-community` vs. `org.graalvm.truffle:java`, which still differ in the bundled Java runtime.
  * Embedders using auxiliary engine caching, polyglot isolates, a isolated or untrusted sandbox policy, or the sandbox resource limits must now explicitly add the `org.graalvm.truffle:truffle-enterprise` Maven artifact to the classpath or module path.
* Improved the memory isolation between multiple isolates, known as **Monocle** or **Software Fault Isolation**.
Monocle is a new mitigation for speculative execution attacks for runtime-compiled code running inside GraalVM isolates. With Monocle enabled, every load generated from untrusted code is either (a) masked so it cannot address memory outside its own isolate heap, or (b) guarded by a lightweight fence when masking is impossible. This keeps one isolate from speculatively reading data belonging to another isolate in the same GraalVM process. Monocle is about 4x faster compared to the previous, fence-based mitigation, while delivering the same security guarantees. It is available for the AMD64 architecture and can be enabled with `-R:+MemoryMaskingAndFencing`.
Monocle is used for polyglot isolates. As a result, sandboxed code execution is faster.
* The option `sandbox.MaxStackFrames` is no longer mandatory for the `UNTRUSTED` polyglot sandbox policy, due to improved deoptimization handling in compiled code. Removing the option significantly improves performance of the sandboxed code.
* The WebAssembly (Wasm) language is now available as a polyglot isolate under the name `wasm-isolate` on Maven Central. Wasm is now supported for untrusted code execution (all three are polyglot isolates related).

Find a complete list of updates in the [changelog](https://github.com/oracle/graal/blob/master/sdk/CHANGELOG.md#version-2500).

### Truffle Framework

* Added the deoptimization cycle detection feature, which is enabled by default. When a deoptimization cycle is detected, the compilation fails with a permanent bailout that includes the Java stack trace of the problematic location. If this error is encountered too frequently it can be disabled by setting `compiler.DeoptCycleDetectionThreshold` to `-1`. For further information, see the [Automatic Detection of Deoptimization Cycles guide](https://github.com/oracle/graal/blob/master/truffle/docs/Optimizing.md#automatic-detection-of-deoptimization-cycles).
* Implemented the extended Dynamic Object Model Layout that adds:
  * A shape obsolescence strategy enabling optimistic type speculation for primitive property values. When speculation fails, shapes gradually migrate to more general forms (for example, moving primitive slots to reference slots), eventually converging on a stable, general shape tree. This reduces shape polymorphism by replacing overly specific shapes with more general ones.
  * Automatic reference type tracking based on assumptions, which eliminates redundant type checks.
  * Automatic single-assignment tracking based on assumptions allowing languages to assume that a property is effectively final (i.e. stays unchanged after the initial assignment) as well as constant-fold values of a constant receiver with a known shape.
  * You can still disable the new layout and switch back to the previous implementation using the system property `-Dtruffle.object.LayoutFactory=com.oracle.truffle.api.object.CoreLayoutFactory`.
* Enabled lazy deoptimization of runtime-compiled code by default for native-image hosts, which reduces memory used for deoptimization. It can be turned off using the `-H:-LazyDeoptimization` option.
* Now you can specify language and instrument specific options using `Source.Builder.option(String, String)`. Languages may describe available source options by implementing the methods `TruffleLanguage.getSourceOptionDescriptors()` and `TruffleInstrument.getSourceOptionDescriptors()` respectively.
* Added multiple improvements to [Bytecode DSL](https://github.com/oracle/graal/blob/master/truffle/docs/bytecode_dsl/BytecodeDSL.md):
  * Improved builder performance: creating bytecode nodes is now 40% faster and requires five times less temporary memory.
  * Builder instances now implement `toString()`, which prints both the current operations and the instructions already emitted. This should make debugging builder usage easier.
  * Improved variadic support: variadic operands now compile and execute more efficiently, with fewer reallocations.
  * Added a `startOffset` parameter to `@Variadic`, allowing reservation of a fixed number of slots in the object array for custom use. The `@Variadic` annotation can now also be applied to `@Operation`-annotated classes to indicate that the operation produces a dynamic variadic return value. Dynamic `@Variadic` return values are efficiently flattened into the object array of a `@Variadic` operand.
  * Added a `variadicStackLimit` parameter to `@GenerateBytecode` that allows to specify how many variable arguments are stored on the stack before they are collapsed into an object array.

Find a complete list of updates in the [Truffle changelog](https://github.com/oracle/graal/blob/master/truffle/CHANGELOG.md#version-250).
