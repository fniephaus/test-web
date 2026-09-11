---
layout: toc_content_ecosystem
title: GraalVM for JDK 21
link_title: GraalVM for JDK 21
permalink: "/release-notes/JDK_21/"
toc_group: release-notes
---

# GraalVM for JDK 21.0.2
(2024-01-16)

This is the January 2024 Critical Patch Update (CPU) for GraalVM Community Edition.
It is based on the OpenJDK CPU and includes all the OpenJDK security fixes released as part of that CPU, platform updates, and some GraalVM bug fixes.
It is a full distribution and supersedes the previous release of GraalVM Community Edition for JDK 21.

* Updated _GraalVM Community Edition for JDK 21.0.1_ to **21.0.2+13**. See the [OpenJDK 21 Updates](https://wiki.openjdk.org/display/JDKUpdates/JDK+21u "OpenJDK 21 Updates").
* Version compatibility:
    * [Truffle languages and other components](https://www.graalvm.org/jdk21/reference-manual/#specific-languages) version **23.1.2** are designed for use with **GraalVM for JDK 21.0.2**.
* Compiler fixes:
    * Rearranged binary arithmetic operations that may be re-associated for loop invariants and constants.
    * Fixed Sulong benchmarks failing because of compilation failures.
    * Improved the AArch64 architecture support: allowed `BranchOp` to emit `FarBranch`; made AArch64 HotSpot null constant code generation more generic.
    * Ensured Guards Anchor to `CaptureStateBegin`.
    * The compiler now checks stamps before casting in `IntegerLessThanNode`.
    * `HeapImpl.dirtyAllReferencesOf` must be no-op for the Epsilon garbage collector.
    * Simplified the `ValueAnchorNode` implementation.
    * Removed explicit null check exceptions during generation of `checkcast` and `instanceof`.
* Native Image fixes:
    * Updated OS detection code to recognize Windows 11 and Windows Server 2022.
    * Added an option that allows VM operations to exceed the max heap size.
    * Fixed a problem with `-XX:+PrintGCSummary` if assertions are enabled.
    * Fixed crashes during isolate teardown.
    * Native Image now ignores crashed threads.
    * Improved the OutOfMemoryError messages.
    * Native Image now reports consistent values when memory usage is queried via `MemoryPoolMXBean`.
    * Introduced the `--disable-debuginfo-stripping` argument for the `mx` tool.
    * Fixed handling `native-image` JSON properties stored in the wrong location.
    * Added a fix to prevent `System.console().readPassword` failures.
    * Improved mangling of primitive types in BFD name mangler#7423.
    * Fixed the `native-image --bundle-create,container` command failing if a driver is an image.
    * Made the initialization cycle break in NIO/cgroups code.
    * Fixed a transient guarantee failure in `PointsToAnalysisMethod.getContextInsensitiveVirtualInvoke`.
    * Improved the JFR support: switched to `PlatformThreads.getCurrentThreadOrNull()` instead of `Thread.currentThread()`; fixed race condition in `JVM.commit(long)`.
    * Ensured `DeoptTargets` are generated for methods requiring `FrameInformation`.
    * Now the Native Image builder uses synchronized data structures for reachability handlers registration.
    * Added an async-signal-safe way to dump crash logs.
    * Added an option to artificially increase the header size.
    * Fixed stack walking heuristic used for the Native Image crash log.
    * Fixed `joinThreadUnmanaged` on Windows.
    * Used the vendor version for `__svm_version_info`.
    * Made the builder use `ThreadLocal` for `AccessControlContext` stack.
    * Fixed class-path order when MANIFEST files include "Class-Path" attributes.
    * Added support for execution of bootstrap methods at image run time, and support "constant dynamic" execution at image run time.
    * Native Image now prints crash log when exception handling fails.
    * Fixed `clinit` simulation for `arraycopy` with null values.
    * Included signers in the native executable only if registered.
    * Do not use the shadow heap for fields annotated with `@Unknown*Field`.
* Truffle framework fixes:
    * Handle _json-23.1.0.jar_ _native-image.properties_ stored in the wrong location.
    * Upgraded the JSON parser library, [org.json](https://www.json.org/json-en.html), to version 20231013.
    * Fixed regression in spawning an Espresso context on platforms where it runs on Sulong.
    * Fixed handling unlinked types in runtime compilation.
    * Disabled the class-path isolation by default.
    * Added polyglot version checks for unchained.
    * Added assertion triggers check that fails and throws an exception.
* Tools:
    * Added the mandatory experimental property `debuggerId` and handle GET of the _/json/list_ path.
* Javascript:
    * Updated the expected Node.js structure after the update to version 18.18.2.
    * Prevent automatic leave of an explicitly entered context during close called from a host call.
* LLVM:
    * Initializing LLVM fails if built with Xcode 15.
    * Regression in the Sulong library loading when IO access is denied.
* Java on Truffle (Espresso):
    * Removed the need for a foreign field in `EspressoForeignList`.
    * Added missing Espresso artifacts on Maven.
    * Fixed `ToEspresso` collection type nodes not handling Espresso objects.
    * Fixed type converter combination for foreign exceptions and custom type converters.
* Python:
    * Fixed Python JVM standalones only working on GraalVM Community Edition.
* WebAssembly:
    * File system access from GraalWasm.
* TRegex:
    * Added OracleDB flavor.
* GraalVM integration:
    * Fixed a list of deployed artifacts.
    * Lambda without a target invoke.

# GraalVM for JDK 21.0.1
(2023-10-24)

This is the October 2023 Critical Patch Update (CPU) for GraalVM Community Edition.
It is based on the OpenJDK CPU and includes all the OpenJDK security fixes released as part of that CPU, platform updates, and some GraalVM bug fixes.
It is a full distribution and supersedes the previous release of GraalVM Community Edition for JDK 21.

* Updated _GraalVM Community Edition for JDK 21_ to **21.0.1+12**. See the [OpenJDK 21 Updates](https://wiki.openjdk.org/display/JDKUpdates/JDK+21u "OpenJDK 21 Updates").
* Version compatibility:
    * [Truffle languages and other components](https://www.graalvm.org/jdk21/reference-manual/#specific-languages) version **23.1.1** are designed for use with **GraalVM for JDK 21.0.1**.
* Compiler fixes:
    * Changed constant blinding to use `RuntimeRandomness` for ahead-of-time compilation.
    * Added `FarBranch` support for `BranchOp` for the AArch64 architecture.
* Native Image fixes:
    * Fixed process crashing when uncommitting unused memory.
    * Added `CEntryPointError` if the stack boundaries cannot be determined.
    * Removed no longer needed JDK-specific Java Flight Recorder code.
    * Fixed an occasional crash using `ProcessBuilder` on macOS.

# GraalVM for JDK 21
(2023-09-19)

* [Platform and Distributions](#platform-and-distributions)
* [Removed Functionality](#removed-functionality)
* [Java and Compiler](#java-and-compiler)
* [Native Image](#native-image)
* [Polyglot Embedding](#polyglot-embedding)
* [JavaScript and Node.js](#javascript-and-nodejs)
* [Java on Truffle](#java-on-truffle-espresso)
* [Python](#python)
* [Ruby](#ruby)
* [WebAssembly](#webassembly)
* [LLVM](#llvm)
* [Truffle Language and Tool Implementations](#truffle-language-and-tool-implementations)

### Platform and Distributions

* Released **GraalVM Community Edition for JDK 21** based on OpenJDK 21. See [OpenJDK 21 Updates](https://jdk.java.net/21/ "OpenJDK 21 Updates").
* Released **Oracle GraalVM for JDK 21** based on Oracle JDK 21. See [Java SE 21 Release Notes](https://www.oracle.com/java/technologies/javase/21-relnote-issues.html "Java SE 21 Release Notes").
* Released language runtimes as standalone distributions, therefore there are no language launchers in the GraalVM JDK.
Two standalone language runtime options are available for both Oracle GraalVM and GraalVM Community Edition: a Native Image compiled native launcher or a JVM-based runtime (included).
To distinguish between the GraalVM editions, the GraalVM Community Edition version has the suffix `-community` in the name, for example:  `graaljs-community-<version>-<os>-<arch>.tar.gz.`
To distinguish between the runtime mode, a JVM standalone type has the `-jvm` suffix in a name.
Standalone distributions are available on GitHub, in corresponding language repositories.
Learn more [here](https://medium.com/p/ee01177dd12d).

### Removed Functionality

* Removed GraalVM Updater, `gu`, used to extend GraalVM installations with GraalVM language runtimes and other components by modifying the installation directory.
As part of the [alignment with OpenJDK](https://www.graalvm.org/2022/openjdk-announcement/), modifying JDK installations is not common.
To continue using the GraalVM language runtime(s) and other components, use language standalones or specify them as Maven or Gradle dependencies in your project.
For more information, see [Polyglot Embedding updates](#polyglot-embedding) and the [GitHub issue #6855](https://github.com/oracle/graal/issues/6855).
* Removed the option `--language:<language>` (to enable a specific language runtime at build time) and some macro options. [See below](#polyglot-embedding) for more details.

### Java and Compiler

* Implemented initial optimization of [Java Vector API (JEP 338)](https://openjdk.org/jeps/338) operations.
Load, store, basic arithmetic, reduce, compare, and blend operations are transformed to efficient machine instructions where possible.
It is enabled by default and can be disabled with `-Dgraal.OptimizeVectorAPI=false`.
This optimization is not available in GraalVM Community Edition and not yet available in GraalVM Native Image.
Coverage of more operations and Native Image support are planned for the future.
This optimization is experimental.
* Implemented all intrinsics prior to JDK 21 on both AMD64 and AArch64 architectures for the Graal compiler.
We have also ported various HotSpot assembly stubs into Java, including all of the SHA message digest stubs and part of the `BigInteger` arithmetic computation stubs.
This allows Native Image to benefit from these high performance assembly codes.
* Users can enable backward-edge CFI in the Graal compiler by setting the `-XX:UseBranchProtectionHotSpot` option.
Whether the user provides standard or PAC-RET protection, the Graal compiler will automatically enable backward-edge CFI when running on the AArch64 architecture.
Before a function returns, the Graal compiler issues an authentication instruction that checks the integrity of the signed return address.
If this integrity check fails, the authentication instruction stamps the higher bits of the corrupted address reserved for the pointer authentication code (PAC) to invalidate the pointer.
When the function returns to the corrupted pointer, then the OS will raise a SIGSEGV signal, since the corrupted pointer now refers to an invalid (for example, unmapped) address.
Even if an adversary has full control over the stored return address, the authentication instruction takes away control by resetting whatever the adversary provides to a random point high up in the process address space.
Learn more about `UseBranchProtection` [here](https://blogs.oracle.com/javamagazine/post/java-19-enhancements-fixes-deprecations).
* The following JDK 21 features are not available:
    * [JEP 439](https://openjdk.org/jeps/439) Generational ZGC

### Native Image

#### New Features
* Users can now use G1 Garbage Collector on the Linux AArch64 architecture to build efficient native executables with large heaps and minimal pause times (not available in GraalVM Community Edition).
Previously, it was only available for Linux AMD64.
To enable it, pass the option `--gc=G1` to the `native-image` builder.
Learn more about [Memory Management in Native Image](../../docs/reference-manual/native-image/MemoryManagement.md).
* Introduced a new class initialization approach that will become the default in the future: all classes are now allowed to be used and initialized at build time, regardless of the class initialization configuration. For classes that are configured as `--initialize-at-run-time` this means that they will appear as uninitialized again at run time. To enable the new approach, pass the `--strict-image-heap` flag to Native Image. For more information and implementation details, take a look at the [proposal #4684](https://github.com/oracle/graal/pull/4684). Note that there is a known issue when a build that does not satisfy the new policy would fail with the following error: `Boolean option value can be only + or -`. This will be resolved in a patch release on October 24, 2023 and we will share more details on the new policy and best practices in the upcoming blog post.
* Improved the reporting of missing metadata by throwing `MissingReflectionRegistrationError` when attempting to create a `Proxy` class without having it registered at build time, instead of `VMError`.
* Added optimization level 3 to the `native-image` builder for the best peak performance (not available in GraalVM Community Edition).
This new level includes optimizations that previously were part of optimization level 2 and that work best together with [Profile-Guided Optimizations](../../docs/reference-manual/native-image/guides/optimize-native-executable-with-pgo.md).
As a result, the compilation time when building with the default `-O2` is significantly reduced.
Also, the `--pgo` option automatically enables `-O3`.
* Added experimental support for foreign down calls ([OpenJDK project Panama](https://openjdk.org/jeps/424)) in Native Image. Please test it and provide feedback. Support for upcalls is planned for the future.
* Added the option `--parallelism` to control how many threads are used by the Native Image build process. The minimal number is 2. This option is useful for build environments with constrained resources.
Also, starting from this release, the build output will print out the memory and thread limits of the build process, for example:

    ```bash
    Build resources:
    - 13.24GB of memory (42.7% of 31.00GB system memory, determined at start)
    - 16 thread(s) (100.0% of 16 available processor(s), determined at start)
    ```
* Added the option `--color[=WHEN]` to color the build output. Replace `WHEN` with `always`, `never`, or `auto`.
This API option supersedes the experimental option `-H:+BuildOutputColorful`.
* Introduced a new option `-H:±UnlockExperimentalVMOptions` to explicitly unlock access to experimental options, the majority of hosted options (starting with `-H:`), in Native Image.
If access is not explicitly requested, an attempt to use any experimental option will fail the build with an actionable error message in this release.
Also, to help users understand which dependencies requested these options, active experimental options will be listed as part of the build output alongside their origin.
In the next release, this warning will be turned into a build failure.
Meanwhile, the community is encouraged to open issues if certain experimental options should be promoted to public API and marked as stable.
For more information, see [GitHub issue #7105](https://github.com/oracle/graal/issues/7105).
* The following JDK 21 features are not available:
    * [JEP 439](https://openjdk.org/jeps/439) Generational ZGC
    * [JEP 442](https://openjdk.org/jeps/442) Foreign Function & Memory API (Third Preview)
    * [JEP 448](https://openjdk.org/jeps/448) Vector API (Sixth Incubator)

#### Debugging and Monitoring Improvements

* Improved the monitoring experience: added support for the Java Flight Recording `ThreadCPULoad` event. (Together with BellSoft.)
* Added support for `-XX:+HeapDumpOnOutOfMemoryError`. (Together with Red Hat.)

See a complete list of updates in [the changelog](https://github.com/oracle/graal/blob/master/substratevm/CHANGELOG.md#graalvm-for-jdk-21-internal-version-2310).

### Refactoring GraalVM SDK

The GraalVM SDK is split into four fine-grained modules.
The use of the `graalvm-sdk` module is now deprecated.
Note that all GraalVM APIs remain compatible in this release.
The following new modules are available:
* `org.graalvm.nativeimage`: The public API of Native Image for advanced use cases.
* `org.graalvm.polyglot`: A library that allows to embed polyglot language implementations in Java.
* `org.graalvm.word`: A low-level library for machine-word-sized values in Java.
* `org.graalvm.collections`: A collections library for GraalVM components.

Update your Maven and module dependencies accordingly.
If you previously used the GraalVM SDK for Native Image via:
```xml
<dependency>
    <groupId>org.graalvm.sdk</groupId>
    <artifactId>graal-sdk</artifactId>
    <version>23.1.0</version>
</dependency>
```
Now you use:
```xml
<dependency>
    <groupId>org.graalvm.sdk</groupId>
    <artifactId>nativeimage</artifactId>
    <version>23.1.0</version>
</dependency>
```
Polyglot embedders can now use:
```xml
<dependency>
    <groupId>org.graalvm.polyglot</groupId>
    <artifactId>polyglot</artifactId>
    <version>23.1.0</version>
</dependency>
```
For more details, see [Polyglot Embedding updates](#polyglot-embedding).

Find a complete list of updates in the [GraalVM SDK changelog](https://github.com/oracle/graal/blob/master/sdk/CHANGELOG.md#version-2310).

### Polyglot Embedding

* Turned all GraalVM languages artifacts into standard Maven dependencies for polyglot embedders (see [#6852](https://github.com/oracle/graal/issues/6852)).
Previously, to use a GraalVM language in embeddings, you had to install it using the GraalVM Updater tool (e.g., `gu install python`).
To enable a language now, language artifacts now need to be on the Java module or class path.
* The use of the `graalvm-sdk` module is now deprecated; use the `org.graalvm.polyglot:polyglot` artifact instead.
The `org.graalvm.polyglot` module is no longer contained by default in the GraalVM JDK.
To enable a language embedding in Java, specify the language as a dependency.
If you need the Truffle tools for your polyglot application, enable them through a dependency too.
Below is an example of the Maven configuration:
    ```xml
    <dependency>
        <groupId>org.graalvm.polyglot</groupId>
        <artifactId>polyglot</artifactId>
        <version>23.1.0</version>
    </dependency>
    <dependency>
        <groupId>org.graalvm.polyglot</groupId>
        <!-- Select the language -->
        <artifactId>js|python|ruby|wasm|llvm|java</artifactId>
        <version>23.1.0</version>
        <type>pom</type>
    </dependency>
    <dependency>
        <groupId>org.graalvm.polyglot</groupId>
        <artifactId>tools</artifactId>
        <version>23.1.0</version>
        <type>pom</type>
    </dependency>
    ```
    These dependencies use the language and tools built on top of Oracle GraalVM.
    To use the GraalVM Community Edition version, add the suffix `-community` to `artifactId`, for example, `js-community`. Please refer to the updated [Embedding Languages documentation](../../docs/reference-manual/embedding/embed-languages.md) for further details.
* Removed the option `--language:<language>` (to enable a specific language runtime at build time) and some macro options, namely:

    ```bash
    --macro:polyglot-launcher
    --macro:polyglot-library
    --macro:truffle
    --macro:truffle-language-library
    ```
    They are no longer needed as putting them on the class/module-path does everything necessary.

More updates can be found in the [changelog](https://github.com/oracle/graal/blob/master/sdk/CHANGELOG.md#version-2310).

### JavaScript and Node.js

* Released the JavaScript (GraalJS) and Node.js runtimes as standalone distributions.
Two standalone language runtime options are available for both Oracle GraalVM and GraalVM Community Edition: a Native Image compiled native launcher or a JVM-based runtime (included).
To distinguish between them, the GraalVM Community Edition version has the suffix `-community` in the name: `graaljs-community-<version>-<os>-<arch>.tar.gz.`, `graalnodejs-community-<version>-<os>-<arch>.tar.gz.`,
A standalone that comes with a JVM has a `-jvm` suffix in a name.
Standalone distributions are [available on GitHub](https://github.com/oracle/graaljs/releases/).
* The `ScriptEngine` implementation for running JavaScript is no longer shipped with GraalVM. Migrate your setup to explicitly depend on the `ScriptEngine` module and add it to the module path.
See [ScriptEngine documentation](https://github.com/oracle/graaljs/blob/master/docs/user/ScriptEngine.md) for details.
* To enable the JavaScript runtime, you no longer install it with `gu install js` (since GraalVM Updater is removed), but add it as a Maven dependency (see below), or explicitly put the JAR on the module path.
The Maven dependency for embedding JavaScript into Java were also updated.
Below is the Maven configuration for a JavaScript embedding:
    ```xml
    <dependency>
        <groupId>org.graalvm.polyglot</groupId>
        <artifactId>polyglot</artifactId>
        <version>23.1.0</version>
    </dependency>
    <dependency>
        <groupId>org.graalvm.polyglot</groupId>
        <artifactId>js</artifactId>
        <version>23.1.0</version>
        <type>pom</type>
    </dependency>
    ```
    It enables the Oracle GraalVM JavaScript runtime.
    To use a community-licensed version instead, add the `-community` suffix to each artifact (e.g., `js-community`). See the [dependency setup for language embeddings](https://www.graalvm.org/latest/reference-manual/embed-languages/#dependency-setup).
* Enabled ECMAScript 2023 features by default.
* Implemented new proposals:
    * [Async Context](https://github.com/tc39/proposal-async-context), available behind the experimental option `--js.async-context`.
    * [String.dedent](https://github.com/tc39/proposal-string-dedent), available in ECMAScript staging mode behind the `--js.ecmascript-version=staging` option.
* Updated Node.js to version 18.17.1.

Find more updates in the [project changelog](https://github.com/oracle/graaljs/blob/master/CHANGELOG.md#version-2310).

### Java on Truffle

* Java on Truffle (Espresso) is no longed shipped with GraalVM, but as a separate standalone distribution and a Maven artifact.
Two standalone options are available: Oracle GraalVM and GraalVM Community Edition with a native launcher included.
To distinguish between them, the GraalVM Community Edition version has the suffix `-community` in the name:
`espresso-community-<version>-<os>-<arch>.tar.gz.`
See the [Java on Truffle Getting Started](../../docs/reference-manual/java-on-truffle/README.md).
Standalone distributions are [available on GitHub](https://github.com/graalvm/graalvm-ce-builds/releases/).
* To enable Java on Truffle, you no longer install it with `gu install espresso` (since GraalVM Updater is removed), but add it as a Maven dependency (see below), or explicitly put the JAR on the module path.
    ```xml
    <dependency>
        <groupId>org.graalvm.polyglot</groupId>
        <artifactId>polyglot</artifactId>
        <version>23.1.0</version>
    </dependency>
    <dependency>
        <groupId>org.graalvm.polyglot</groupId>
        <artifactId>java</artifactId>
        <version>23.1.0</version>
        <scope>runtime</scope>
        <type>pom</type>
    </dependency>
    ```
    It enables the Oracle GraalVM Java on Truffle runtime.
* Added the option `--enable-preview`.

Find more updates in the [project changelog](https://github.com/oracle/graal/blob/master/espresso/CHANGELOG.md#version-2310).

### Python

* Released the Python runtime (GraalPy) as a standalone distribution and a Maven artifact (see below).
Two standalone language runtime options are available for both Oracle GraalVM and GraalVM Community Edition: a Native Image compiled native launcher or a JVM-based runtime (included).
To distinguish between them, the GraalVM Community Edition version has the suffix `-community` in the name:
`graalpy-community-<version>-<os>-<arch>.tar.gz.`
A standalone that comes with a JVM has the `-jvm` suffix in a name.
See the [GraalPy Getting Started](https://www.graalvm.org/python/docs/).

    You can install a GraalPy Community standalone also with `pyenv`:
    ```bash
    # To install GraalPy Community Edition
    pyenv install graalpy-community-23.1.0
    ```
    Standalone distributions are [available on GitHub](https://github.com/oracle/graalpython/releases/).
* To enable GraalVM Python for embedding into Java, add it as a Maven dependency or explicitly put the JAR on the module path. Below is the Maven configuration for a Python embedding:
    ```xml
    <dependency>
        <groupId>org.graalvm.polyglot</groupId>
        <artifactId>polyglot</artifactId>
        <version>23.1.0</version>
    </dependency>
    <dependency>
        <groupId>org.graalvm.polyglot</groupId>
        <artifactId>python</artifactId>
        <version>23.1.0</version>
        <type>pom</type>
    </dependency>
    ```
* GraalPy is now available for Windows users. GraalPy can be installed on Windows with  `venv` or `pip` tools, and supports compilation and execution of C extensions using the native MSVC toolchain.
* Improved the GraalPy standalone tool: you can now build single-file executable Python binaries for Linux, Windows, and macOS. The tool can also generate a skeleton Maven project that sets up a polyglot embedding of Python packages into Java.
* Added support for the `sqlite3` module. This allows many packages like [Coverage](https://coverage.readthedocs.io/en/7.3.0/) or [Flask-SQLAlchemy](https://pypi.org/project/Flask-SQLAlchemy/) to work on top of an embedded database.

Find more updates in the [project changelog](https://github.com/oracle/graalpython/blob/master/CHANGELOG.md#version-2310).

### Ruby

* Updated to Ruby 3.2.2.
* TruffleRuby standalone for Linux, built on Oracle GraalVM Native Image, now supports the G1 garbage collector which provides significantly better run-time performance.
* The TruffleRuby `ScriptEngine` implementation is removed in favor of the [generic `ScriptEngine` in GraalVM](https://github.com/oracle/graal/blob/master/docs/reference-manual/embedding/embed-languages.md#compatibility-with-jsr-223-scriptengine).

See a complete list of updates in [the project changelog](https://github.com/oracle/truffleruby/blob/master/CHANGELOG.md#2310).

### WebAssembly

* Released the GraalVM WebAssembly runtime as a standalone distribution.
Two standalone language runtime options are available for both Oracle GraalVM and GraalVM Community Edition: a Native Image compiled native launcher or a JVM-based runtime (included).
To distinguish between them, the GraalVM Community Edition version has the suffix `-community` in the name:
`wasm-community-<version>-<os>-<arch>.tar.gz.`
A standalone that comes with a JVM has the `-jvm` suffix in a name.
See the [WebAssembly Getting Started](https://github.com/oracle/graal/blob/master/wasm/README.md).
Standalone distributions are [available on GitHub](https://github.com/graalvm/graalvm-ce-builds/releases/).
* Implemented the [extended const expressions](https://github.com/WebAssembly/extended-const) proposal. The feature can be enabled with the option `--wasm.ExtendedConstExpressions=true`.
* Added the option to enable multiple memories within a Wasm module: `--wasm.MultiMemory=true`.

### LLVM

* The GraalVM LLVM runtime is no longed shipped with GraalVM, but as a separate standalone distribution.
It contains the LLVM toolchain by default.
Two standalone language runtime options are available for both Oracle GraalVM and GraalVM Community Edition: a Native Image compiled native launcher or a JVM-based runtime (included).
To distinguish between them, the GraalVM Community Edition version has the suffix `-community` in the name:
`llvm-community-<version>-<os>-<arch>.tar.gz.`
A standalone that comes with a JVM has the `-jvm` suffix in a name.
See the [LLVM Getting Started](../../docs/reference-manual/llvm/README.md).
Standalone distributions are [available on GitHub](https://github.com/graalvm/graalvm-ce-builds/releases/).
* Updated LLVM toolchain to version 16.0.1.
* Added the `flang` toolchain wrapper to enable Fortran compilation with embedded bitcode.

### Truffle Language and Tool Implementations

* Truffle language and tools implementations are isolated from the embedder using the Java module-based isolation.
This means that they were migrated to Java modules to prevent accidental use of internal APIs.
See the details of Truffle languages and instruments required modularization in [this document](https://github.com/oracle/graal/blob/master/truffle/docs/ModuleMigration.md).
* Implemented the [Internal Resource API](https://www.graalvm.org/truffle/javadoc/com/oracle/truffle/api/InternalResource.html) for Truffle languages and instruments to be able to lazily unpack and consume resources from the application module path, necessary for execution.
This API replaces the concept of "language homes".
For a language or instrument that requires additional files to execute, it needs to follow these steps:
    * Bundle the necessary files into a standalone distribution (JAR).
    * Implement the [`InternalResource` interface](https://www.graalvm.org/truffle/javadoc/com/oracle/truffle/api/InternalResource.html) for handling the resource file unpacking.
    * Call the `Env#getInternalResource` method when a language or instrument needs the bundled resource files. This method ensures that the requested `InternalResource` is unpacked and provides a directory containing the unpacked files. Since unpacking internal resources can be an expensive operation, the implementation ensures that internal resources are cached.
* Truffle languages or instruments are now loaded from the application module path, unlike before when they were provided using `-Dtruffle.class.path.append` on a GraalVM JDK.
The Truffle class path is deprecated and should no longer be used.
Languages now need to be capable of running as named modules, so the [language needs to be migrated](https://github.com/oracle/graal/blob/master/truffle/docs/ModuleMigration.md).
Languages can still be loaded from the class path, but Truffle internally loads them in its own classloader and module layer, so they are required to become modules.
* Improved [Ideal Graph Visualizer](https://github.com/oracle/graal/blob/master/docs/tools/ideal-graph-visualizer.md) dumping experience:
    * IR dumping: folders for Truffle now include the compilation tier to differentiate compilations better. Inlined IR graphs are now additionally dumped in separate folders if dump level is >= 2.
    * AST dumping: the Truffle AST is now dumped as part of the IR dump folder. The dumped AST tree now shows all inlined ASTs in a single tree. Individual functions can be grouped using the "Cluster nodes" function in IGV (top status bar). Root nodes now display their name. Every AST node now has a property `graalIRNode` that allows to find the corresponding Graal IR constant if there is one.

Find a complete list of updates in the [Truffle changelog](https://github.com/oracle/graal/blob/master/truffle/CHANGELOG.md#version-2310).
