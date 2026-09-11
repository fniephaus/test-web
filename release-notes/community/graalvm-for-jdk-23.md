---
layout: toc_content_ecosystem
title: GraalVM for JDK 23
link_title: GraalVM for JDK 23
permalink: "/release-notes/JDK_23/"
toc_group: release-notes
---

# GraalVM for JDK 23.0.2
(2025-01-21)

This is the January 2025 Oracle Critical Patch Update (CPU) for GraalVM Community Edition for JDK 23.
It is based on the OpenJDK CPU and includes all the OpenJDK security fixes released as part of that CPU, platform updates, and some GraalVM bug fixes.
It is a full distribution and supersedes the previous release of GraalVM Community Edition for JDK 23.

* Updated _GraalVM Community Edition for JDK 23_ to **23.0.2+7**. See the [OpenJDK 23 Updates](https://jdk.java.net/java-se-ri/23).
* Version compatibility:
  * [Truffle languages and other components](https://docs.oracle.com/en/graalvm/support-roadmap.html) version **24.1.2** are designed for use with **GraalVM for JDK 23.0.2**.

This release also includes the following fixes:
* Graal compiler
  * Fix Vector API `CompareNode` propagating the wrong `unorderIsTrue` value.
  * Add an explicit null check on `StringBuilder(String)` constructor's argument.
  * Infinite recursion in `AArch64MacroAssembler.add/sub` with `immediate = Integer.MIN_VALUE`.
  * Add safepoint policy changes.
  * Fix source launcher regression.
  * Ensure only safepoint usages are left.
  * Allow no exit safepoint if end safepoints are disabled.
* Native Image
  * Preserve local symbols if post-link stripping follows.
  * Adopt JDK-8314794: Improve UTF8 String support.
  * Fix missing state for `StoreIndexedNode`.
  * Make missing registration warn mode stack trace length customizable.
  * Improve Visual Studio detection in Native Image and related error messages.
  * Make `PosixPlatformTimeUtils.javaTimeSystemUTC` uninterruptible.
  * Fix a problem with invalid PGO profiles during Native Image build.
* Truffle framework
  * Clear polyglot source cache more aggressively.
  * Handle static frame slots in `BytecodeOSRMetadata#restoreParentFrame`.
  * Fix documentation for the `sandbox.MaxHeapMemory` resource limit.
  * Fix int overflow in `ObjectSizeCalculator#increaseByArraySize`.
* GraalJS
  * Include GraalWasm in the JavaScript standalone.
  * Fix of `top-level` `for-await-of` in a module.
  * Handle mixing overloaded operators with non-numeric primitives.
  * Fix missing return value conversion in `Polyglot.eval[File]`.
* GraalWasm
  * Handle static frame slots in `BytecodeOSRMetadata#restoreParentFrame`.
* GraalPy
  * Improve manifest files.
  * Shared engine cannot be used with `GraalPyResources`.
  * Fix GraalPy Gradle plugin that fails to build if a project does not contain any resource files.
* Espresso
  * Fix duplicate class definition attempts for generated type-mapped proxies.
  * Remove the workaround for array-based static object crash.
* TruffleRuby
  * Change order of module creation steps and assign a module's full name before calling the `Module#const_added` callback.

## GraalVM for JDK 23.0.1
(2024-10-15)

This is the October 2024 Oracle Critical Patch Update (CPU) for GraalVM Community Edition for JDK 23.
It is based on the OpenJDK CPU and includes all the OpenJDK security fixes released as part of that CPU, platform updates, and some GraalVM bug fixes.
It is a full distribution and supersedes the previous release of GraalVM Community Edition for JDK 23.

* Updated _GraalVM Community Edition for JDK 23_ to **23.0.1+11**. See the [OpenJDK 23 Updates](https://jdk.java.net/23/release-notes).
* Version compatibility:
  * Truffle languages and other components version **24.1.1** are designed for use with **GraalVM for JDK 23.0.1**.
* Graal compiler:
  * Avoid `getHostBackend` when instantiating `UnimplementedGraalIntrinsics`.
* Native Image:
  * Prevent emission of `typeReachable` in the _reachability-metadata.json_.
  * Reset the `Provider.Service.constructorCache` field.  
  * Fixed the `--bundle-create` option and bundle-launcher feature on Windows.
  * Move `setConservativeLabelRange` after resetting `crb` on the AArch64 architecture.
  * Do not include `TruffleJfrFeature` if PGO configuration is specified.
  * Made caches in `ValueConversions` initialize eagerly.
  * Added version information to the manifest only when it is available from the suite.
* Truffle framework:
  * Fixed the Addr part alignment in Truffle compilation logs.
* JavaScript:
  * Made the option `js.webassembly` stable.
* GraalWasm:
  * Removed constant memory buffer assumption and simplified `ByteArrayWasmMemory`.
* GraalPy:
  * Created GraalPy Gradle plugin with similar features as the GraalPy Maven plugin.
  * Updated the `bouncycastle` dependency.
  * Deprecated exposed Truffle filesystem spi in `VirtualFileSystem`.

# GraalVM for JDK 23
(2024-09-17)

* [Platform and Distributions](#platform-and-distributions)
* [Availability of JDK 23 Features](#availability-of-jdk-23-features)
* [Graal Compiler](#graal-compiler)
* [Native Image](#native-image)
* [Polyglot Runtime](#polyglot-runtime)
* [Polyglot Embedding](#polyglot-embedding)
* [Espresso](#espresso)
* [GraalJS](#graaljs)
* [GraalPy](#graalpy)
* [GraalWasm](#graalwasm)
* [Truffle Language and Tool Implementations](#truffle-language-and-tool-implementations)

### Platform and Distributions

* Released **Oracle GraalVM for JDK 23** based on Oracle JDK 23. See [Java SE 23 Release Notes](https://www.oracle.com/java/technologies/javase/23-relnote-issues.html).
* Released **GraalVM Community Edition for JDK 23** based on OpenJDK 23. See [OpenJDK 23 Updates](https://jdk.java.net/23/).
* Version compatibility:
    * GraalVM for JDK 23 is compatible with [Truffle languages and other components](https://www.graalvm.org/jdk23/reference-manual/languages) version **24.1.0**.

### Availability of JDK 23 Features

* [455: Primitive Types in Patterns, instanceof, and switch (Preview)](https://openjdk.org/jeps/455)
* [466: Class-File API (Second Preview)](https://openjdk.org/jeps/466)
* [467:	Markdown Documentation Comments](https://openjdk.org/jeps/467)
* [471:	Deprecate the Memory-Access Methods in sun.misc.Unsafe for Removal](https://openjdk.org/jeps/471)
* [473:	Stream Gatherers (Second Preview)](https://openjdk.org/jeps/473)
* [476: Module Import Declarations (Preview)](https://openjdk.org/jeps/476)
* [477:	Implicitly Declared Classes and Instance Main Methods (Third Preview)](https://openjdk.org/jeps/477)
* [480:	Structured Concurrency (Third Preview)](https://openjdk.org/jeps/480)
* [481:	Scoped Values (Third Preview)](https://openjdk.org/jeps/481)
* [482:	Flexible Constructor Bodies (Second Preview)](https://openjdk.org/jeps/482)
 
Enable preview features by passing `--enable-preview` to use any of them.

### Graal Compiler

* Introduced a new compiler optimization to reduce code size on the x64 architecture, by emitting smaller jump instructions if the displacement fits in one byte. This optimization is enabled for Native Image by default and disabled elsewhere. Use `-Djdk.graal.OptimizeLongJumps=true` to enable.
* Starting from JDK 24, the Graal options specified via a `-Dgraal.` prefix will be deprecated and result in a deprecation warning.

### Native Image

#### New Features

* Added a new optimization level, `-Os`, to configure the optimizer to get the smallest code size and, thus, a reduced file size. It enables `-O2` optimizations except those that can increase code or executable size significantly. Learn more in [Native Image Optimization Levels](https://www.graalvm.org/jdk23/reference-manual/native-image/optimizations-and-performance/).
* Replaced `typeReachable` conditions with [`typeReached`](https://www.graalvm.org/jdk23/reference-manual/native-image/metadata/#conditional-metadata-entries). `typeReached` conditions make the metadata entry available at run time when the type is considered *reached*. A type is reached at run time, right before the [class-initialization routine](https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-5.html#jvms-5.5) starts for that type (class or interface), or any of the type's subtypes are reached.
* Streamlined Native Image reachability metadata configuration into a single file _reachability-metadata.json_. The formerly-used individual metadata files (_reflection-config.json_, _resource-config.json_, and so on) are now deprecated, but will still be accepted. See the [documentation](https://www.graalvm.org/jdk23/reference-manual/native-image/metadata/) for more details.
* Added support for glob patterns to specify file path to a resource in addition to Java regular expressions. The Tracing Agent now prints entries in the glob format. Learn more in [Accessing Resources in Native Image](https://www.graalvm.org/jdk23/reference-manual/native-image/metadata/#resources).
* Enabled the registration of `java.lang.reflect.Proxy` classes for reflection by adding `proxy`-type entries. This allows members of `Proxy` classes to be accessed reflectively at run time. The metadata file _proxy-config.json_ is now deprecated, but will still be honored for backward compatibility. The Tracing Agent is modified to use the new approach. The new format to specify proxy classes in _reachability-metadata.json_ is:
    ```json
    {
      "reflection": [
        {
          "type": { "proxy": [ "IA", "IB" ] }
        }
      ]
    }
    ```
* Added a stable name for the Proxy types in Native Image. The name `$Proxy[id]` is replaced by `$Proxy.s[hashCode]` where `hashCode` is computed using the names of the Proxy interfaces, the name of the class loader, and the name of the module if it is not a dynamic module.
* Introduced a `type` field in reflection and JNI configuration files to support more than simple name types.
* Improved the Foreign Function & Memory API ([JEP 454](https://openjdk.org/jeps/454)) by adding experimental support for upcalls from foreign functions (part of "Project Panama"). Currently, foreign calls are supported on the x64 architecture. Enable with `-H:+ForeignAPISupport`. See [Foreign Function and Memory API in Native Image](https://www.graalvm.org/jdk23/reference-manual/native-image/native-code-interoperability/foreign-interface/) for more details.
* Fields that are accessed via a `VarHandle` or `MethodHandle` are no longer marked as "unsafely accessed" when `VarHandle`/`MethodHandle` can be fully intrinsified. This improves the run-time performance.
* Introduced a new `--static-nolibc` API option to build mostly static native executables. It replaces the experimental `-H:±StaticExecutableWithDynamicLibC` option.
* Implemented the compact garbage collection mode for the Serial GC old generation. Enable it with the `-H:+CompactingOldGen` option. The primary intention is to reduce the memory usage compared to the copying GC. Find more details at [github.com/oracle/graal/pull/8870](https://github.com/oracle/graal/pull/8870). This is an experimental feature.
* Added the option `-H:+GenerateEmbeddedResourcesFile` to print information about embedded resources into _embedded-resources.json_.
* Added support to catch `OutOfMemoryError` exceptions at build time if there is no memory left.
* Changed the digest (used, for example, for symbol names) from SHA-1 encoded as a hex string (40 bytes) to 128-bit Murmur3 as a Base-62 string (22 bytes).

#### Deprecated Functionality

* The old class initialization strategy, which was deprecated in GraalVM for JDK 22, is now removed. The option `--StrictImageHeap` no longer has any effect.
* Reporting unsupported elements at run time is now enabled by default. The option `--report-unsupported-elements-at-runtime` is deprecated.

#### Improvements

* Added a check to ensure that an explicitly set name (specified via `-o name`) is not accidentally overwritten by the `-jar jarfile` option.
* Added a check that will cause the build process to fail and report an appropriate error if the `--static` option is not followed by `--libc=musl`. Static linking is currently only supported with `musl`.
* In the strict reflection configuration mode (when `ThrowMissingRegistrationErrors` is enabled), `Unsafe.allocateInstance` is allowed only for types registered explicitly in the configuration.
* Native Image now throws missing registration errors for JNI queries when the query was not included in the reachability metadata.

#### Debugging and Monitoring Improvements

* Added a new API option `--emit` to generate build reports. It replaces the experimental host option `-H:+BuildReport`. Providing a path where to store a report is possible via `--emit build-report=custom-build-report.html`, instead of using the old option `-H:BuildReportFile=custom-build-report.html`. (Only available in Oracle GraalVM.)
* Added initial support for the native memory tracking. Enable with `--enable-monitoring=nmt`. (Together with Red Hat.)
* Improved the JFR monitoring experience by adding support for event throttling and the `ObjectAllocationSample` event. Also added the initial support for the `OldObjectSample` event. (Together with Red Hat.)
* Now you can use `vswhere` to find Visual Studio Code installations more reliably and in non-standard installation locations.
* The option `-XX:MissingRegistrationReportingMode` can now be used on the invocation instead of as a build option, to avoid rebuilding when debugging missing registration errors.

### Polyglot Runtime

* Enabled random offsets of runtime compiled functions entry points for the `UNTRUSTED` polyglot sandbox policy.
GraalVM additionally pads the starting offset of functions with a random number of trap instructions which helps prevent a potential JIT spray attack.
* Added `TruffleLanguage.Env.getScopePublic(LanguageInfo)` and `TruffleLanguage.Env.getScopeInternal(LanguageInfo)` to enable languages direct access to other language scopes to implement new polyglot builtins.
* Added `PolyglotException.StackFrame.getBytecodeIndex()` which enables to access the internal bytecode index that the language uses to identify an execution location.

### Polyglot Embedding

* Added the system property `polyglot.engine.userResourceCache` which enables embedders to override the default location of the resources cache directory for a Java application running on HotSpot. By default, the resources cache directory is located in the _org.graalvm.polyglot_ directory within the OS-specific cache directory in the user's home directory. The main rationale behind this override is to accommodate applications running in containers where the user's home directory may not be writable.
* Added the option `engine.InterpreterCallStackHeadRoom` to protect against stack overflow in the middle of a guest method execution in the interpreter. For the `UNTRUSTED` polyglot sandbox policy, the value for the option is computed automatically based on the value of the mandatory option `sandbox.MaxASTDepth`, the option `sandbox.MaxStackFrames` is no longer mandatory. The new option is available only in the AOT mode.
* Added experimental support for virtual threads on HotSpot. Not all languages are currently supported for use with virtual threads. Check the language changelog for further information. Truffle debugging, CPU time limits, and some memory limits are currently not supported on virtual threads. The number of threads is currently limited to 65535 threads entered per context.
* The `RuntimeOptions.listDescriptors` and `getDescriptor` methods also return the Graal compiler options (if any) that could already be accessed through `RuntimeOptions.get` and `set`.
* Java host interop no longer exposes bridge methods.

Find a complete list of updates in the [changelog](https://github.com/oracle/graal/blob/master/sdk/CHANGELOG.md#version-2400).

### Espresso

* Espresso can now use TRegex to execute `java.util.regex` patterns. TRegex offers better performance than the standard implementation. Use `java.UseTRegex` to enable this engine.
* The interop `ReadBuffer` method can now be used from the guest Interop API and guest `ByteBuffer` objects implement this interop message.
* Fixed several JDWP compatibility issues improving the user experience when debugging Espresso with a Java IDE.
* Added the `org.graalvm.continuations` package, along with support for `continuations`. See the [Espresso Continuations](https://github.com/oracle/graal/blob/master/espresso/docs/continuations.md) documentation for more details.
* Added `java.RuntimeResourceId` to enable customizing the resource used to locate the Java standard library used by Espresso. The resource called `espresso-runtime-` will be used. By default, `jdk21`, and then `openjdk21` are attempted.

### GraalJS

* The [JavaScript WebAssembly API](https://www.w3.org/TR/wasm-js-api-1/) is now a stable feature of GraalJS and supported as part of Oracle GraalVM.
* ECMAScript 2024 Language Specification enabled by default.
* Implemented the [Make eval-introduced global vars redeclarable](https://github.com/tc39/proposal-redeclarable-global-eval-vars) proposal.
* Implemented the [Float16Array](https://github.com/tc39/proposal-float16array) proposal. It is available in the ECMAScript staging mode (`--js.ecmascript-version=staging`).
* Implemented the [Array.fromAsync](https://github.com/tc39/proposal-array-from-async) proposal. It is available in the ECMAScript staging mode (`--js.ecmascript-version=staging`).
* Implemented the [Resizable and Growable ArrayBuffers](https://github.com/tc39/proposal-resizablearraybuffer) proposal.
* Made the option `js.esm-eval-returns-exports` stable and allowed in the `TRUSTED` sandbox policy.

### GraalPy

* GraalPy is now considered stable. While many native libraries do work, support for native extensions remains experimental.
* Updated to Python 3.11.7.
* Added the intrinsified `_pickle` module implementation to GraalPy built on top of GraalVM Community Edition.
* The Polyglot API `eval` method now throws more meaningful exceptions when evaluating code from other languages in Python. Exceptions from a language are raised directly as interop objects (typed as `polyglot.ForeignException`). The shortcut for executing Python code without specifying a language was removed. Use the regular `eval` method.

### GraalWasm

* GraalWasm is now considered stable.
* Implemented the [SIMD](https://github.com/WebAssembly/simd) proposal. This feature is enabled by default and can be disabled with the option `--wasm.SIMD=false`.
* Added support for the `clock_res_get`, `fd_advise`, `fd_datasync`, `fd_fdstat_set_rights`, `fd_filestat_set_size`, `fd_pread`, `fd_pwrite`, `fd_readdir`, `fd_renumber`, `fd_sync`, and `fd_tell` functions.

### Truffle Language and Tool Implementations

* Deprecated `Node.getCost()` and the associated `NodeCost` class without replacement. A Truffle DSL no longer generates implementations of this method automatically and will therefore always return `NodeCost.MONOMORPHIC` by default. This is intended to reduce the binary footprint.
* Improved the debugging experience: 
    * `DebuggerSession.suspend(Thread thread)` now preserves ongoing stepping strategies.
    * Added `SuspendedEvent.isStep()`, `SuspendedEvent.isUnwind()`, and `SuspendedEvent.isBreakpointHit()` to enable debugger backends or languages to query reasons for the suspension.
* Added the [MathUtils API](https://www.graalvm.org/truffle/javadoc/com/oracle/truffle/api/utilities/MathUtils.html) providing additional mathematical functions useful for language implementations such as `asinh`, `acosh`, and `atanh`.
* Added the `UnadoptableNode` interface. This interface should be preferred to overriding `Node.isAdoptable()` if the result is statically known.

Find a complete list of updates in the [Truffle changelog](https://github.com/oracle/graal/blob/master/truffle/CHANGELOG.md#version-2400).