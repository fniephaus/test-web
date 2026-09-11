---
layout: toc_content_ecosystem
title: GraalVM Release Candidates
link_title: Release Candidates
permalink: "/release-notes/release-candidates/"
toc_group: release-notes
---

# GraalVM Release Candidates

## 1.0-RC16
(2019-04-23)

### Java

We addressed several benchmarks that had slower performance when running with the GraalVM compiler built as a native library, also known as [libgraal](https://github.com/oracle/graal/tree/master/compiler#libgraal), a mode selected as the default in the last release candidate. We fixed an issue causing a delay when shutting down the virtual machine process at the end of the execution of an application
(see [#1140](https://github.com/oracle/graal/issues/1140)).

### Native Image
We improved the structure of the `org.graalvm.nativeimage` API: classes that can
only be used during image generation are now in the package
`org.graalvm.nativeimage.hosted`, to clearly separate them from the classes that
can be used at image run time. In order to stay backwards compatible, the
original classes are still present, but marked as deprecated. They will be
deleted in the next release candidate, so please update to the new classes.

We fixed several bugs that were reported on GitHub, including an
issue with the logging framework which materialized as an error that no instances of `java.util.logging.SimpleFormatter` are allowed in the image heap.

As a result, native images work now correctly with **Helidon**, a Java
framework designed for writing microservices which recently announced their
support for GraalVM native images:
[Helidon flies faster with GraalVM](https://medium.com/oracledevs/helidon-flies-faster-with-graalvm-eea85287d2dc).

### Ruby
A complete [changelog](https://github.com/oracle/truffleruby/blob/master/CHANGELOG.md)
 for the Ruby component is available on GitHub. The highlights include:

* Rounding modes have been implemented or improved for `Float`, `Rational`, `BigDecimal` classes (see [#1509](https://github.com/oracle/truffleruby/issues/1509)).
* Added a pure-Ruby implementation of Foreign Function Interface (FFI) which passes almost all Ruby FFI specs (see [#1529](https://github.com/oracle/truffleruby/issues/1529)).
* The `KeyError` raised from `ENV#fetch` and `Hash#fetch` now matches MRI's message formatting (see [#1633](https://github.com/oracle/truffleruby/issues/1633)).

### JavaScript

A complete [changelog](https://github.com/graalvm/graaljs/blob/master/CHANGELOG.md#version-100-rc16)
 for the JavaScript component is available on GitHub. The highlights include:

* [Loading JavaScript source code](https://github.com/graalvm/graaljs/blob/master/docs/user/JavaScriptCompatibility.md#loadsource) from URLs is now guarded by the
`js.load-from-url` command line option and prohibited by default.

### R

A complete [changelog](https://github.com/oracle/fastr/blob/master/CHANGELOG.md#10-rc-16)
 for the R component is available on GitHub. The highlights include:

* Allow parsing any letter in identifiers
including, e.g., Japanese, with `lexer` starting from 1.0-RC16, which matches
GNU-R behavior.

### Python

* Improved startup time of the `graalpython` native launcher.

### LLVM Runtime

* The `lli` launcher now starts with the locale set to `C`.

## 1.0-RC15
(2019-04-05)

### Java

By default,
[libgraal](https://github.com/oracle/graal/tree/master/compiler#libgraal) is now
used when running the `java` launcher or when using the `--jvm` mode for the
language launchers. The **libgraal library** is a version of the GraalVM compiler
pre-compiled by `native-image`. In addition to improving startup time, libgraal
completely prevents the GraalVM compiler from interfering with the heap usage and
profiles of application code. It has execution properties similar to other
native HotSpot compilers such as C1 and C2.

### JavaScript

* Enabled `Polyglot` builtin based on `Context.Builder.allowPolyglotAccess()`.
* Added rest and spread properties support for foreign objects. For example, this spread syntax is now supported:
```
var arr1 = [0, 1, 2];
var arr2 = [3, 4, 5];
arr1 = [...arr1, ...arr2]; // arr1 is now [0, 1, 2, 3, 4, 5]
```

To see a complete list of changes, please refer to the project [changelog](https://github.com/graalvm/graaljs/blob/master/CHANGELOG.md#version-100-rc15).

### R

##### New Features

* Implemented `gzcon` builtin for URL connections.

##### Changes
* Truffle interoperability API converts `double` values to `int` values if they
fit in the integer range.

##### Bug Fixes
* R incorrectly allowed Java interoperability when not started with `--jvm`.
Starting from 1.0-RC15, `--jvm` flag is again necessary to enable interoperability with Java.

A complete project [changelog](https://github.com/oracle/fastr/blob/master/CHANGELOG.md#10-rc-15)  is available on GitHub.

### Ruby

An extensive list of changes is available [on GitHub](https://github.com/oracle/truffleruby/blob/master/CHANGELOG.md).
Here is a short list of the most notable ones:

##### Changes
* Our experimental JRuby-compatible Java interop has been removed -- use `Polyglot` and `Java` instead.
* `Process.clock_getres` has been implemented.
* `debug`, `profile`, `profiler`, which were already marked as unsupported, have been removed.

##### Bug Fixes
* `autoload :C, "path"; require "path"` now correctly triggers the autoload.
* The shell standard library can now be `require`-d.

##### Compatibility
* Improved compatibility with MRI's `Float#to_s` formatting [#1626](https://github.com/oracle/truffleruby/issues/1626).
* Added support for the base keyword argument to `Dir.{[], glob}`.


### Python

##### Changes
* Migrated to the new Truffle libraries for interoperability support.
* Added support for importing Java classes from the `java` namespace using normal Python import syntax, e.g., `from java.util import ArrayList`.
* Implemented PEP 487 and PEP 560 to make the `typing` module work.

More details can be found in the [project changelog on GitHub](https://github.com/graalvm/graalpython/blob/master/CHANGELOG.md#version-100-rc15).

### LLVM Interpreter

* Added  a preliminary support for bitcode produced by LLVM 8.

### Native Image

Based on the feedback and bug reports, we improved the agent that traces reflection
and JNI usage on the JavaHotSpot VM. We also changed the implementation language
of the agent from C to Java. The agent is now a Native Image itself.

The **native-image-maven-plugin** now supports multiline `buildArgs` and
boolean parameter `skip` (skip image building if true).

### API changes for GraalVM integrators (SDK + Truffle)

This version of GraalVM includes a major revision of the [Truffle
Interoperability
APIs](https://www.graalvm.org/truffle/javadoc/com/oracle/truffle/api/interop/package-summary.html).
Most existing APIs for Truffle Interoperability were deprecated. The
compatibility layer may cause significant performance reduction for
interoperability calls. Please see the [Interop Migration
Guide](https://github.com/oracle/graal/blob/master/truffle/docs/InteropMigration.md)
for an overview and individual `@deprecated` javadoc tags for guidance.

We added Truffle Library API that allows language implementations to use
polymorphic dispatch for receiver types with support for implementation specific
caching/profiling with support for uncached dispatch. Please see the [Truffle
Library
Tutorial](https://github.com/oracle/graal/blob/master/truffle/docs/TruffleLibraries.md)
for further details.


The numerous changes were introduced to the GraalVM SDK Polyglot API as well:

* Renamed **Graal SDK** to [**GraalVM SDK**](https://www.graalvm.org/sdk/javadoc/).
* Experimental options now require `--experimental-options` on the command line to
be passed to the GraalVM language launchers, or
`Context.Builder#allowExperimentalOptions` and
`Engine.Builder#allowExperimentalOptions` to be set in other scenarios.
For example, to diagnose the memory allocations of a JavaScript application with `--memtracer` profiling tool,
you should prepend `--experimental-options` option:
`js --experimental-options --memtracer program.js`.
* Added a possibility to set [an encoding in Source builder](https://www.graalvm.org/sdk/javadoc/org/graalvm/polyglot/Source.Builder.html#encoding-java.nio.charset.Charset-).
* Added a new API for target type mappings using the new HostAccess API.

We summarized all Truffle and SDK changes between GraalVM versions in separate changelogs:

- [GraalVM SDK changelog](https://github.com/oracle/graal/blob/master/sdk/CHANGELOG.md#version-100-rc15)
- [GraalVM Truffle changelog](https://github.com/oracle/graal/blob/master/truffle/CHANGELOG.md#version-100-rc15)

### Tools

#### Chrome Inspector

* Object Preview feature added for GraalVM implementation of JavaScript.
* Implemented a Custom Preview experimental feature for all languages supported by GraalVM.

#### Ideal Graph Visualizer (IGV)

Starting with 1.0-RC15 version of GraalVM, Ideal Graph Visualizer will be
provided as standalone download from [Oracle Technology Network Downloads](https://www.oracle.com/downloads/graalvm-downloads.html) page. It is not part of GraalVM Community or Enterprise editions.

## 1.0-RC14
(2019-03-18)

##### Introducing `--vm.<option>`
We introduced a uniform `--vm.<option>` which allows to pass options in a uniform way, without knowing which VM mode (`--jvm`, or `--native`) will be used. It replaces  `--jvm.<option>` and `--native.<option>` command line options, e.g., the option to configure the maximum amount of memory used for the heap `--jvm.Xmx=5G` becomes `--vm.Xmx=5G`.
This applies to all languages.

### Java
##### libgraal
This is the first release to include a prebuilt [libgraal](https://github.com/oracle/graal/tree/master/compiler#libgraal) shared library. This shared library is produced by the native-image and contains a pre-compiled version of the GraalVM compiler. In addition to improving startup, libgraal completely avoids interfering with the heap usage and profiling of the application code. That is, it has execution properties similar to other native HotSpot compilers such as C1 and C2. To try it out, add `-XX:+UseJVMCINativeLibrary` to your `java` command line. Note that this is still a work in progress and we are focusing on improving its stability and ensuring it does not compromise peak performance.

##### Default Failure Behavior
The default behavior has changed for a failure (i.e., uncaught exception) during
the compilation. These are now silently ignored and nothing is printed to the
console. To get the old behavior of a message being printed to the console and
for collecting diagnostics about the failure, you now need to specify
`-Dgraal.CompilationFailureAction=Diagnose` option.

### Native Images
##### New Features
We introduced a tracing agent for the Java HotSpot VM that records usages of reflection and JNI that can then be converted to configuration files for the native image generator. This simplifies the process of getting new applications working as native images. For details, see the [documentation](../../docs/reference-manual/native-image/AutomaticMetadataCollection.md).

We improved support for the `java.util.logging` API. See the [GitHub docs](../../docs/reference-manual/native-image/guides/add-logging-to-native-executable.md) for details.

The `javax.script.ScriptEngine` API is now supported. Please note that the Nashorn JavaScript engine does not work in native images and is therefore always excluded. However, Truffle based language implementations such as the GraalVM JavaScript engine are available when, e.g., the native image is built with the option `--language:js`.

Implemented the `Class.getSimpleName` method for the native images (see [1020](https://github.com/oracle/graal/issues/1020)).

##### Bugfixes
* Fixed an NPE during native image generation at accessing annotations metadata on the classes opened for reflection (see [1048](https://github.com/oracle/graal/issues/1048)).

* Fixed `createTempFile()` providing non-default file system and failing (see [1035](https://github.com/oracle/graal/issues/1035)).

* Fixed a segfault due to incorrect socket address length value (see [1025](https://github.com/oracle/graal/issues/1025)).



### JavaScript
##### HTML-like Comments
We added support for [HTML-like comments](https://tc39.github.io/ecma262/#sec-html-like-comments).
```javascript
var s = "Introducing html-like comments";
alert(s);
<!-- this is a comment -->
```
##### Changes
* Renamed the option `js.experimental-array-prototype` to `js.experimental-foreign-object-prototype`.

More details can be found in the [project changelog](https://github.com/graalvm/graaljs/blob/master/CHANGELOG.md#version-100-rc14) on GitHub.

### R

The GraalVM implementation of R in this release comes with various bug fixes and improvements.

##### Error Propagation
According to the R semantics, errors are handled immediately at the point where they are raised. However, in language embedding or polyglot scenarios, it is more useful to have the errors propagate out of the R scope, so that they can be handled correctly. We changed the behavior of FastR in this regard so that now R errors are propagated. Note that this only happens if this is possible without causing unexpected side effect in R code,
i.e., if there are no `options(error = ...)` or `on.exit(...)` handlers on the stack.

##### Experimental Options
All specific options (NOT those GNU-R compatible like `--save`) are experimental except for `--R.PrintErrorStacktracesToFile`, which is an option that enables logging of FastR internal errors for bug reporting purposes. Experimental options can be unlocked using `--experimental-options` or with `ContextBuilder#allowExperimentalOptions`.

To see a complete list of changes, please refer to the project [changelog](https://github.com/oracle/fastr/blob/master/CHANGELOG.md#10-rc-14).


### Ruby

This version of GraalVM features new methods implementations and other updates for Ruby implementation.

##### New Features
* Implemented `Dir.children` and `Dir#children`, `String#delete_prefix`, `#delete_suffix` and related methods.

##### Changes

* `-Xlog=` has been removed. Use `--log.level=` instead.
* `-J` flag has been removed. Use `--vm.*` instead.
* `-J-cp lib.jar` and similar have been removed. You should use `--vm.cp=lib.jar` or `--vm.classpath=lib.jar` instead.
* The `-X` option now works as in MRI.

An extensive list of changes is available on [GitHub](https://github.com/oracle/truffleruby/blob/master/CHANGELOG.md#10-rc-14).

### Python
##### Python 3.7.0
The standard library was updated to Python 3.7.0 from 3.6.5.
##### Changes
* Defined a subset of the `graalpython` launcher options as "stable". All other options are subject to change and need to be unlocked explicitly on the command line.
* Added the support for  `-I` flag to ignore the user environment and not add the working directory to `sys.path`.

More details can be found in the [project changelog on GitHub](https://github.com/graalvm/graalpython/blob/master/CHANGELOG.md#version-100-rc14).

### LLVM Runtime

* Various bug fixes.

### API Changes for GraalVM Integrators (SDK + Truffle)

##### New Features
* Added [Context.Builder#allowExperimentalOptions](http://www.graalvm.org/sdk/javadoc/org/graalvm/polyglot/Context.Builder.html#allowExperimentalOptions-boolean-) to control whether experimental options can be passed to a Context.
* Added [Engine.Builder#allowExperimentalOptions](http://www.graalvm.org/sdk/javadoc/org/graalvm/polyglot/Engine.Builder.html#allowExperimentalOptions-boolean-) to control whether experimental instrument and engine options can be passed.
* The [`@Option`](http://www.graalvm.org/truffle/javadoc/com/oracle/truffle/api/Option.html) annotation can now specify the stability of an option.
* Added engine bound `TruffleLogger` for instruments. The engine bound logger can be used by threads executing without any context.

##### Changes
* Multiple deprecated elements were removed from  the Truffle language implementation framework, i.e., `TruffleException.isTimeout`, `EventBinding.getFilter` etc..

We summarized GraalVM Truffle and GraalVM SDK changes between GraalVM versions in the separate changelogs:

- [GraalVM SDK changelog](https://github.com/oracle/graal/blob/master/sdk/CHANGELOG.md#version-100-rc14)
- [GraalVM Truffle changelog](https://github.com/oracle/graal/blob/master/truffle/CHANGELOG.md#version-100-rc14)

## 1.0-RC13
(2019-03-05)

### Tools
**Ideal Graph Visualizer**

With GraalVM 1.0-RC13 release, there has been a significant change to the
Ideal Graph Visualizer developer tool. The default behavior of the `Dgraal.Dump`
option has changed in that IGV dumps are now written to the local file system by default.
To get the old behavior of dumping straight to an IGV instance listening on _127.0.0.1:4445_,
you need to add `-Dgraal.PrintGraph=Network` option.
If a network connection cannot be opened, dumping falls back to file system dumping.

**Graal VisualVM**

Another developer tool, Graal VisualVM, now allows Heap monitoring of native-image processes.
This functionality is available with Oracle GraalVM.

### R
* R specific command line options are now passed as `–R.PrintErrorStackTracesToFile=true` instead of using JVM properties (`–jvm.R:+PrintErrorStackTracesToFile`). You can view available options with `--help:languages`.
* Optional post installation script, _configure_fastr_, also regenerates _etc/Renviron_ and _etc/ldpaths_ files according to the target system.
* R vectors are not writeable from other languages, because this would violate the R language semantics.

A list of changes to GraalVM implementation of R is available [on GitHub](https://github.com/oracle/fastr/blob/master/CHANGELOG.md#10-rc-13).

### JavaScript
* Node.js updated from 10.15.0 to version 10.15.2.
* Made JavaScript and Java interoperability available in native images. Note that you have to configure the accessible classes and methods at native image build time.
* Node.js `Worker` class should be used instead of deprecated experimental `Java.Worker` API now.
* A deprecated `NashornJavaInterop` mode was removed.

More details can be found in the [project changelog](https://github.com/graalvm/graaljs/blob/master/CHANGELOG.md#version-100-rc13) on GitHub.

### LLVM Runtime

* Added the support for embedded bitcode in Mach-O files. We support bitcode in the `__bitcode` section of Mach-O object files, as well as bitcode files in an embedded xar archive in the `__bundle` section of executables or `dylibs`. For example, on OS X, you can compile your code with `clang -fembed-bitcode -flto hello.c -o hello`, creating a native executable with embedded bitcode. You can then run it natively (`./hello`) or with GraalVM (`$JAVA_HOME/bin/lli ./hello`).

The full [project changelog](https://github.com/oracle/graal/blob/master/sulong/CHANGELOG.md#version-100-rc13) is available on GitHub.

### Ruby

This release of GraalVM is rich in performance and compatibility improvements,
multiple changes and bug fixes for Ruby implementation.

An extensive list of all updates is available on  [Github](https://github.com/oracle/truffleruby/blob/master/CHANGELOG.md#10-rc-13).  Here is a short list of most notable ones:

New features:

* Host interoperability with Java now works on SubstrateVM too.

Changes:

* `-Xoptions` has been deprecated and will be removed. Use `--help:languages` instead.
* `-Xlog=` has been deprecated and will be removed. Use `--log.level=` instead.
* `-J` has been deprecated and will be removed. Use `--jvm.` instead.
* `-J-cp lib.jar` and so on have been deprecated and will be removed. Use
  `--jvm.cp=lib.jar` or `--jvm.classpath=lib.jar` instead.
* `-J-cmd`, `--jvm.cmd`, `JAVA_HOME`, `JAVACMD`, and `JAVA_OPTS` do not work in any released
  configuration of TruffleRuby, so have been removed.
* `-Xoption=value` has been deprecated and will be removed. Use `--option=value` instead.
* `TracePoint.trace` and `TracePoint#inspect` have been implemented.

Compatibility:

* Improved the exception when an `-S` file is not found.
* Removed the message from exceptions raised by bare `raise` to better match MRI [#1487](https://github.com/oracle/truffleruby/issues/1487).
* `TracePoint` now handles the `:class` event.

Note that GraalVM 1.0-RC13 implementation of Ruby is built on Ruby 2.4.4, and it
is still vulnerable to CVE-2018-16395. This will be fixed in the next release.

### Python

New feature:

* Allow installation of NumPy in a `venv`. Just run e.g., `bin/graalpython -m venv numpy_env; source numpy_env/bin/activate; graalpython -m ginstall install numpy`. Note that not all NumPy features work at the moment.

To see a complete list of changes, please refer to the project [changelog](https://github.com/graalvm/graalpython/blob/master/CHANGELOG.md#version-100-rc13).


### API Changes for GraalVM Integrators (SDK + Truffle)

* Added [Debugger.getSessionCount()](https://www.graalvm.org/truffle/javadoc/com/oracle/truffle/api/debug/Debugger.html#getSessionCount--) to return the number of active debugger sessions.
* `TruffleLanguage` class now can register additional services. This change also deprecates the automatic registration of the language class as a service.
* [`OptionCategory.DEBUG`](https://www.graalvm.org/truffle/javadoc/org/graalvm/options/OptionCategory.html) has been renamed to `OptionCategory.INTERNAL` for clarity.
* Added `static` member to class objects that provides access to the class's static members.
* [`OptionStability`](https://www.graalvm.org/truffle/javadoc/org/graalvm/options/OptionStability.html)
has been added for specifying the stability of an option.

All GraalVM SDK and Truffle changes between GraalVM versions are summarized in the project changelogs:
- [GraalVM SDK changelog](https://github.com/oracle/graal/blob/master/sdk/CHANGELOG.md#version-100-rc13)
- [GraalVM Truffle changelog](https://github.com/oracle/graal/blob/master/truffle/CHANGELOG.md#version-100-rc13)

## 1.0-RC12
(2019-02-04)

### Native Image Generation
Native images now check the remaining available stack size on every method call,
and throw a `StackOverflowError` on stack overflows.

We continued the work on the support of incomplete classpaths. There were no big changes,
but only small bug fixes based on users feedback. The support for incomplete classpaths
now allows to run the native image generator with bytecode verification,
i.e., the option `--no-verify` is no longer passed to the Java HotSpot VM
when running the native image generator.

### R
An extensive list of changes to GraalVM implementation of R is available [on GitHub](https://github.com/oracle/fastr/blob/master/CHANGELOG.md#10-rc-12). Here is a short list of most notable ones:

* FastR now uses the R base function `print` to implement `TruffleLanguage#toString`, so that tools and debuggers (like the Chrome Dev Tools console) format values (e.g., `data.frame` objects) in a familiar, R-like, way.
* GraalVM implementation of R provides GNU-R compatible `parseData` for expressions parsed via `parse(...,keep.source=T)`, which enables packages that use this functionality (like `lambda.r` and `plumber`) to work.
* Added a dummy implementation of the ALTREP framework to avoid linking problems.

### JavaScript
* Updated Node.js from 10.9.0 to version 10.15.0.
* A new option `js.experimental-array-prototype` added to set prototype of array-like non-JS objects (like `ProxyArray` or Java List) to `Array.prototype`. It makes it possible to use functions like `map` or `forEach` on these objects directly.

More details can be found in the [project changelog](https://github.com/graalvm/graaljs/blob/master/CHANGELOG.md#version-100-rc12) on GitHub.

### LLVM Runtime
* In order to streamline the polyglot APIs in LLVM Runtime, we deprecated the `truffle_*` builtin functions. We also broke binary compatibility to bitcode compiled with `polyglot.h` from version 1.0.0-RC2 (or older).
* Read-only globals are now placed in read-only memory. This was necessary to accommodate some changes in mac OS Mojave's libc that raise errors when format strings are placed in the writable memory.

The [project changelog](https://github.com/oracle/graal/blob/master/sulong/CHANGELOG.md#version-100-rc12) is available on GitHub.

### Ruby
This version came with the compatibility improvements:

* Change to a new system for handling Ruby objects in C extensions which greatly increases compatibility with MRI.
* Support for `BigDecimal#to_r` was implemented (See [#1521](https://github.com/oracle/truffleruby/issues/1521)).

A complete project [changelog](https://github.com/oracle/truffleruby/blob/master/CHANGELOG.md#10-rc-12) is available on GitHub.

### Python
To see a complete list of changes, please refer to the project [changelog](https://github.com/graalvm/graalpython/blob/master/CHANGELOG.md#version-100-rc12).

* Added support for the `__class__` variable in the class scope.
* Initial support of the `venv` standard-library tool, the built-in `_bz2` module and the `pandas` package was started up.

### API Changes for GraalVM Integrators (SDK + Truffle)
GraalVM SDK and Truffle changes between GraalVM versions are summarized in the project changelogs:

- [GraalVM SDK changelog](https://github.com/oracle/graal/blob/master/sdk/CHANGELOG.md#graal-sdk-changelog)
- [GraalVM Truffle changelog](https://github.com/oracle/graal/blob/master/truffle/CHANGELOG.md#version-100-rc12)

### Tools
**Graal VisualVM**

* Added the ability to create native image heap dump directly from Graal VisualVM interface.
* Improved heap dump support in the native image.

## 1.0-RC11
(2019-01-14)

### Native Image Generation

We improved the handling of incomplete classpaths, i.e., code that references classes that are not provided on the classpath. The approach we took for RC10 caused problems in corner cases that would have been difficult to fix, therefore we implemented a different approach. Thanks to everyone who tried our initial approach and reported problems on GitHub. We attempted to verify that all reported problems are solved with the new approach.

### JavaScript

* Graal.js only supports ECMAScript 5 (ES5) and newer, and enforces that rule.
* Added support for sharing Java objects using the experimental Node.js Worker Threads API.
* Added support for ScriptEngine GLOBAL_SCOPE bindings.
* Added options to enable/disable several extension features e.g., `print()` or `load()`.
* Added options to disable features for security reasons e.g., `eval()`.

More details can be found in the [project changelog on GitHub](https://github.com/graalvm/graaljs/blob/master/CHANGELOG.md#version-100-rc11).

### LLVM Runtime

GraalVM now reports source filenames and line numbers for LLVM functions in stack traces if the bitcode is compiled with debug information, even if the original source is not available.

Find a complete [changelog](https://github.com/oracle/graal/blob/master/sulong/CHANGELOG.md#version-100-rc11) on GitHub.

### Ruby

A complete project [changelog](https://github.com/oracle/truffleruby/blob/master/CHANGELOG.md#10-rc-11) is available on GitHub. Here is a short list of most notable changes:

* Allowed signal `0` to be used with `Process.kill` (see [#1474](https://github.com/oracle/truffleruby/issues/1474)).
* Implemented `Dir.each_child`.
* Added missing support for the `close_others` option to `exec` and `spawn`.
* Implemented the missing `MatchData#named_captures` method (see [#1512](https://github.com/oracle/truffleruby/issues/1512)).
* `Process::CLOCK_` constants have been given the same value as in standard Ruby.
* All core files now make use of frozen `String` literals, reducing the number of `String` allocations for core methods.

### Python

The [changelog](https://github.com/graalvm/graalpython/blob/master/CHANGELOG.md#version-100-rc11) is available on GitHub.

* Added the `ginstall` custom module to install known packages such as NumPy and setup tools using `graalpython -m ginstall`.
* Added support for the `yield from` syntax.
* Added more built-in methods to the `time` module.
* Added support for the standard `zipfile` module.
* Added the built-in `_cvs` module.
* Various bug fixes and performance improvements.
* Removed the exposure of internal languages through `polyglot.eval`.

### R

* The R version was upgraded to R-3.5.1.
* R does not print or log any details for internal errors unless it is run with  `--jvm.DR:+PrintErrorStacktracesToFile`.
* Newly implemented R native API functions:  `Rf_duplicated`, `Rf_setVar`, `norm_rand`, `exp_rand`.
* Numerous bug fixes.

More details can be found in the project [changelog](https://github.com/oracle/fastr/blob/master/CHANGELOG.md#10-rc-11) on GitHub.


### API Changes for GraalVM Integrators (SDK + Truffle)

Please refer to the project changelogs for a list of APIs changes:
- [GraalVM SDK changelog](https://github.com/oracle/graal/blob/master/sdk/CHANGELOG.md#version-10-rc11)
- [GraalVM Truffle changelog](https://github.com/oracle/graal/blob/master/truffle/CHANGELOG.md#version-100-rc11)


### Tools

**Graal VisualVM**

* Added CPU monitoring of native-image processes.
* Improved the search feature in text views - thread dumps, OQL console results, etc..
* Heap viewer is now displaying JVM arguments, has improved performance and memory management.

## 1.0-RC10
(2018-12-05)

Bug fixes and performance improvements across all GraalVM components.

### Native Image Generation

Added a new option `--allow-incomplete-classpath` with GraalVM 1.0-rc10. By default (without specifying this option), classes that are reachable, but missing on the class path, are reported at native image generation time. When specifying this new option, missing classes are only reported at run time. The option provides support for, e.g., libraries that probe the existence of classes, catch the class loading error, and then fall back to a different behavior. This should result in more applications being able to compile to a GraalVM native image.

### JavaScript
The project [changelog](https://github.com/graalvm/graaljs/blob/master/CHANGELOG.md#version-100-rc10) is available on GitHub.

* Added the ability to construct the Java classpath programmatically. If you know at runtime where the classes and jar files are located -- you can add them to the classpath and use Java code from them.
* Compatibility: added support for several proposals which might become parts of ECMAScript 2019: [Array.prototype.{flat,flatMap}](https://github.com/tc39/proposal-flatMap), [well-formed JSON.stringify](https://github.com/tc39/proposal-well-formed-stringify), [globalThis](https://github.com/tc39/proposal-global).
* Compatibility: moved several non-standard builtins behind flags (see the  [changelog](https://github.com/graalvm/graaljs/blob/master/CHANGELOG.md#version-100-rc10)).

### LLVM Runtime
* Improved the debugging experience: internal functions (originating from the GraalVM LLVM interpreter implementation) are now hidden in the stack traces by default and can be debugged with `--inspect.Internal`; and unhandled exceptions are now output to `stderr` instead of `stdout`.

More details can be found in the [project changelog on GitHub](https://github.com/oracle/graal/blob/master/sulong/CHANGELOG.md#version-100-rc10).

### Ruby
GraalVM 1.0-rc10 implementation of Ruby comes with several new features and multiple bug fixes
which can be found in the project [changelog](https://github.com/oracle/truffleruby/blob/master/CHANGELOG.md#10-rc-10) on GitHub.

* Compatibility: implemented the following API and added libraries:
  * The `nkf` and `kconv` standard libraries were added.
  * `Queue` and `SizedQueue`, `#close` and `#closed?`, have been implemented.
  * `Kernel#clone(freeze)` has been implemented.
  * `Warning.warn` has been implemented.
  * `Thread.report_on_exception` has been implemented.
* Compatibility: `ArgumentError` messages now better match MRI.

### Python
* Several users-facing improvements were made to the embedding interfaces: getting/setting the current working directory in Python now uses the appropriate Truffle APIs, Python will report side effects in the KEY_INFO message, and the KEYS message now responds with attributes and methods (not with dict keys).
* The interactive `help()` builtin now works, including asking about language and syntax.

A complete project [changelog](https://github.com/graalvm/graalpython/blob/master/CHANGELOG.md#version-100-rc10) is available on GitHub.

### R
Made important steps for compatibility with the R ecosystem:

* Improved the support for popular packages: Rcpp modules, `dplyr` now mostly works,
and FastR provides its own version of `data.table` (work in progress).
* A new builtin function `install.fastr.packages(pkgs)` can be used to install FastR-specific versions of the `rJava` and `data.table` packages.
* Fixed linking problems on macOS when installing R packages and using Fortran code.

The full [changelog](https://github.com/oracle/fastr/blob/master/CHANGELOG.md#10-rc-10)
is available on GitHub.

### API Changes for GraalVM Integrators (SDK + Truffle)
To see the list of changes to the APIs please refer to the project changelogs:
- [GraalVM SDK changelog](https://github.com/oracle/graal/blob/master/sdk/CHANGELOG.md#version-10-rc10)
- [GraalVM Truffle changelog](https://github.com/oracle/graal/blob/master/truffle/CHANGELOG.md#version-100-rc10)

### Tools
**Graal VisualVM**

Several quality of life improvements:
* Added the display of system properties for SVM heap dumps.
* Added support for the fields histogram and merged references for guest languages: JavaScript, Ruby, and so on.
* Improved CPU Sampler accuracy.

**Ideal Graph Visualizer**
* The tool understands `mx` project structure now, e.g., the GraalVM compiler project when opening sources.
* Improved performance when laying out large graphs.

## 1.0-RC9
(2018-11-05)

### GraalVM for Java Developers (GraalVM + compiler)
* Updated based JDK to 8u192. You can find the JDK release notes at the [Oracle Technology Network](https://www.oracle.com/technetwork/java/javase/8u192-relnotes-4479409.html) website.

### Ruby
GraalVM 1.0-rc9 implementation of Ruby features security updates and multiple bug fixes
which can be found in the project [changelog](https://github.com/oracle/truffleruby/blob/master/CHANGELOG.md#10-rc-9-5-november-2018) on GitHub.  Here is a short list of most notable changes:

* LLVM for Oracle Linux 7 can now be installed without building from source.
* The supported version of LLVM for Oracle Linux has been updated from 3.8 to 4.0.
* `mysql2` is now patched to avoid a bug in passing NULL to `rb_scan_args`, and now passes the majority of its test suite.
* The post-install script now automatically detects if recompiling the OpenSSL C extension is needed. The post-install script should always be run in TravisCI as well, see the [documentation](https://github.com/oracle/truffleruby/blob/master/doc/user/standalone-distribution.md).
* Detect when the system `libssl` is incompatible more accurately and add instructions on how to recompile the extension.

### Python
* Added the support `help` in the builtin Python shell.
* Added `readline` to enable history and autocompletion in the Python shell.
* Add support for the `-q`, `-E`, `-s`, and `-S` Python launcher flags.
* Improved support for string and bytes regular expressions using our TRegex engine.
* Started the initial support for the `binascii` module.

A complete project [changelog](https://github.com/graalvm/graalpython/blob/master/CHANGELOG.md#version-100-rc9) is available on GitHub.

### R
* Various improvements in handling of foreign objects in R.
* Added missing R builtins and C API: `eapply builtin` and `rapply builtin`.

More details can be found in the project [changelog](https://github.com/oracle/fastr/blob/master/CHANGELOG.md#10-rc-9) on GitHub.

### JavaScript
A complete [changelog](https://github.com/graalvm/graaljs/blob/master/CHANGELOG.md) is available on GitHub.

### LLVM Runtime
The project [changelog](https://github.com/oracle/graal/blob/master/sulong/CHANGELOG.md) is available on GitHub.

### API Changes for GraalVM Integrators (SDK + Truffle)
* Added `SourceElement.ROOT` and `StepConfig.suspendAnchors()` to tune debugger stepping.
* Added [Context.Builder.logHandler](http://www.graalvm.org/sdk/javadoc/org/graalvm/polyglot/Context.Builder.html#logHandler-java.io.OutputStream-) and [Engine.Builder.logHandler](http://www.graalvm.org/sdk/javadoc/org/graalvm/polyglot/Engine.Builder.html#logHandler-java.io.OutputStream-) methods to install a logging handler writing into a given `OutputStream`.
* Primitives, host and `Proxy` values can now be shared between multiple context and engine instances. They no longer throw an `IllegalArgumentException` when shared.

The major GraalVM SDK and Truffle changes between GraalVM versions are summarized in the project changelogs:
- [GraalVM SDK changelog](https://github.com/oracle/graal/blob/master/sdk/CHANGELOG.md#version-10-rc9)
- [GraalVM Truffle changelog](https://github.com/oracle/graal/blob/master/truffle/CHANGELOG.md#version-100-rc9)

### Tools
**Graal VisualVM**
* Improved Python heapwalker by fixing class names and adding support for `PString`.
* Fixed handling Page Up/Down in `ProfilerTreeTable`. See [GH-109](https://github.com/oracle/visualvm/issues/109) for details.

## 1.0-RC8
(2018-10-19)
### GraalVM for Java Developers (GraalVM + compiler)
* Added the support for Intel bit manipulation instructions. For more details, see [#666](https://github.com/oracle/graal/pull/666).
* Virtualize `unsafe` compare and swap calls on non-escaping objects. See [#636](https://github.com/oracle/graal/pull/636).

### Maven Artifacts
* The **`com.oracle.truffle`** group ID was renamed to **`org.graalvm.truffle`**.
* The `graal-sdk`, `launcher-common` and `polyglot-tck` artifacts were moved from the **`org.graalvm`** group ID to **`org.graalvm.sdk`**.
* New artifacts that are now available:
  - `org.graalvm.compiler:compiler`
  - `org.graalvm.js:js`
  - `org.graalvm.js:js-launcher`
  - `org.graalvm.js:js-scriptengine`
  - `org.graalvm.regex:regex`
  - `org.graalvm.tools:chromeinspector`
  - `org.graalvm.tools:profiler`
  - `org.graalvm.truffle:truffle-nfi`
  - `com.oracle.substratevm:library-support`
  - `com.oracle.substratevm:objectfile`
  - `com.oracle.substratevm:pointsto`
  - `com.oracle.substratevm:svm-driver`
  - `com.oracle.substratevm:svm`
* The artifacts that are now modular JARs:
  - `truffle-api`
  - `graal-sdk`
  - `js`
  - `js-scriptengine`
  - `compiler`
* The `compiler` artifact provides the **`jdk.internal.vm.compiler`** module and can be used to upgrade that module in JDK 11. Unlike the module present in the JDK, this version contains the optimizing Truffle runtime.

### Native Image Generation

* The native image generator now has automatic support for services loaded using ServiceLoader.
All service implementation classes, listed in the `META-INF` directory, are available automatically as soon as the service interface is used. This eliminates the need to manually register resources and reflection support for such classes. The automatic registration can be disabled with the `-H:-UseServiceLoaderFeature` option.
* Finished the support for isolates (starting multiple independent VM instances at run time) and compressed references (to reduce memory footprint; Enterprise Edition only). More details are in an upcoming blog article.
* A new Maven plugin allows native image generation from within a Maven build.
* All components necessary for native image generation (Substrate VM and the GraalVM compiler) are now available on Maven Central. The dependency for that is:
```
    <dependency>
      <groupId>com.oracle.substratevm</groupId>
      <artifactId>svm</artifactId>
      <version>1.0.0-rc8</version>
      <scope>provided</scope>
    </dependency>
```

### JavaScript
* Updated Node.js to version 10.9.0.

A complete [changelog](https://github.com/graalvm/graaljs/blob/master/CHANGELOG.md#version-100-rc8) is available on GitHub.

### LLVM Runtime
The project [changelog](https://github.com/oracle/graal/blob/master/sulong/CHANGELOG.md#version-100-rc8) is available on GitHub.

### Ruby
* Ubuntu 18.04 LTS, Fedora 28, and macOS 10.14 (Mojave) now supported.
* `Java.synchronized(object) { }` and `TruffleRuby.synchronized(object) { }` methods have been added.
* Added a `TruffleRuby::AtomicReference` class.
* Performance of setting the last exception on a thread has now been improved.

A complete project [changelog](https://github.com/oracle/truffleruby/blob/master/CHANGELOG.md#10-rc-8-19-october-2018) is available on GitHub.

### Python
* Python now supports the allocation profiler (`--memtracer`) to analyze the heap usage of applications.

The [changelog](https://github.com/graalvm/graalpython/blob/master/CHANGELOG.md#version-100-rc8) is available on GitHub.

### R
GraalVM 1.0-rc8 implementation of R came up with multiple bug fixes which can be found in the project [changelog](https://github.com/oracle/fastr/blob/master/CHANGELOG.md#10-rc-8) on GitHub.

### Tools
**Graal VisualVM**
* Introduced the CPU and Memory Sampler for guest languages.
* Submitted improvements in the R language heapwalker.

### API Changes for GraalVM Integrators (SDK + Truffle)
The major GraalVM SDK and Truffle changes between GraalVM versions are summarized in the project changelogs:
- [GraalVM SDK changelog](https://github.com/oracle/graal/blob/master/sdk/CHANGELOG.md#version-10-rc8)
- [GraalVM Truffle changelog](https://github.com/oracle/graal/blob/master/truffle/CHANGELOG.md#version-100-rc8)

## 1.0-RC7
(2018-10-03)
### GraalVM for Java Developers (GraalVM + compiler)

* Added the virtualization of `Unsafe` compare and swap calls, for more details see [GH-636](https://github.com/oracle/graal/pull/636).

### Native Image Generation

* Support for the Java security framework, see [JCA-SECURITY-SERVICES.md](../../docs/reference-manual/native-image/JCASecurityServices.md) for the details.
* Support for `https` URL connections, see [URL-PROTOCOLS.md](../../docs/reference-manual/native-image/URLProtocols.md) for more details.

### JavaScript

* Improved support for sharing of shapes between Contexts with the same Engine, which allows to reuse ASTs and objects across different manually created contexts.
* Support for `BigInteger` typed TypedArrays.

More details can be found in the [project changelog on GitHub](https://github.com/graalvm/graaljs/blob/master/CHANGELOG.md#version-100-rc7).

### LLVM Runtime
The full [changelog](https://github.com/oracle/graal/blob/master/sulong/CHANGELOG.md#version-100-rc7) is available on GitHub.

* New polyglot builtin `polyglot_has_member`.
* Removed support for implicit polyglot types for local variables as the availability of type information is not guaranteed. Explicit polyglot casts are now strictly required (`polyglot_as_typed`). See the[Interoperability guide](/reference-manual/llvm/Interoperability/) for more details.
* Support for IR-level (textual representation of bitcode files) tracing, i.e., creating an execution log of all bitcodes that were executed, for debugging purposes.
* Preliminary support for LLVM 7.

### Ruby
The complete [changelog](https://github.com/oracle/truffleruby/blob/master/CHANGELOG.md#10-rc-7-3-october-2018) is available on GitHub. Here is a short list of most notable changes.

* Useful `inspect` strings have been added for more foreign objects.
* Added the `rbconfig/sizeof` native extension for better MRI compatibility.
* Support for `pg` 1.1. The extension now compiles successfully, but may still have issues with some data types.
* `readline` can now be interrupted by the interrupt signal (`Ctrl+C`). This fixes `Ctrl+C` to work in IRB.
* Fixed version check preventing TruffleRuby from working with Bundler 2.0 and later.
* Removed obsoleted patches for Bundler compatibility now that Bundler 1.16.5 has built-in support for TruffleRuby.
* Fixed problem with `Kernel.public_send` not tracking its caller properly
`rb_thread_call_without_gvl()` no longer holds the C-extensions lock.
* Fixed `caller_locations` when called inside `method_added`.
* Fixed `mon_initialize` when called inside `initialize_copy`.

### Python

* Added support for the `re.split` builtin.
* Enhanced the `java` interop builtin module with introspection utility methods.
* Changes in C extension interface to reduce overhead.

The [changelog](https://github.com/graalvm/graalpython/blob/master/CHANGELOG.md#version-100-rc7)
is available on GitHub.

### R

* AWT based graphics devices (jpg, png, X11, ...) is supported when running FastR as a native image.
* `eval.polyglot`: the parameter `source` was renamed to `code`.
* New builtin `as.data.frame.polyglot.value` creates R data frames from Polyglot objects (KEYS are used as column names, the values must be homogenous arrays, e.g., respond to HAS_SIZE).
* Paths in `eval.polyglot` are resolved relative to the current working directory.
* Various fixes necessary to pass _dplyr_ tests (GitHub version of _dplyr_).

More details can be found in the project [changelog](https://github.com/oracle/fastr/blob/master/CHANGELOG.md#10-rc-7) on GitHub.

### Tools
**Ideal Graph Visualizer**
* User can navigate to JavaScript (guest language) source from the graph nodes.
* Ideal Graph Visualizer prompts to download plugins to support JavaScript editing.
* Simple scripts (written in JavaScript) can be applied on graph data.

### API Changes for GraalVM Integrators (SDK + Truffle)

* GraalVM SDK and Truffle license changes from GPL2 with Class Path Exception to the Universal Permissive License (UPL). Please refer to the license files for more information: [GraalVM Truffle license](https://github.com/oracle/graal/blob/master/truffle/LICENSE.md), [GraalVM SDK license](https://github.com/oracle/graal/blob/master/sdk/LICENSE.md).

To see the list of changes to the APIs, please refer to the project changelogs:
- [GraalVM SDK changelog](https://github.com/oracle/graal/blob/master/sdk/CHANGELOG.md#version-10-rc7)
- [GraalVM Truffle changelog](https://github.com/oracle/graal/blob/master/truffle/CHANGELOG.md#version-100-rc7)

## 1.0-RC6
(2018-08-31)
### GraalVM for Java Developers (GraalVM + compiler)

* New optimization to remove unnecessary allocation in some calls to `Enum.values()`.  See [calls to Enum.values() don't optimise away as expected](https://github.com/oracle/graal/issues/574) for the details.

### Native Image Generation

* Delay class initialization to runtime: By default, all classes that are seen as
reachable for a native image are initialized during image building, i.e., the
class initialization method is executed during image building and is not seen as
a reachable method at runtime. But for some classes, it is necessary to execute
the class initialization method at runtime. This is now possible using the new
option `--delay-class-initialization-to-runtime=<comma separate list of class
names>` or using the new API `RuntimeClassInitialization` class.
* Direct byte buffer are no longer allowed in the image heap: We added a new verification during image generation to ensure that no direct or mapped byte buffers (`MappedByteBuffer` instances) are in the image heap. Such buffers have either a pointer to C memory or reference a file descriptor, i.e., native resources that are available during image generation but no longer at image runtime. Using such a buffer would lead to a segfault at runtime. We discovered this issue because Netty has a few direct buffers that are created in class initializers. It is necessary to delay the initialization of such classes to runtime.
* Better automatic discovery of classes, methods, and fields accessed via reflection. When String parameters of `Class.forName`, `Class.getMethod`, `Class.getField`, and other similar classes can be constant folded during image generation, then these classes, methods, and fields are automatically registered for reflection usage and do not need to be registered manually on the command line. Constant String parameters are a common pattern to support, e.g., different JDK versions or different library versions where a class, method, or field is not present in all cases and therefore cannot be used directly.

### LLVM Runtime

The full [changelog](https://github.com/oracle/graal/blob/master/sulong/CHANGELOG.md#version-100-rc6)
is available on GitHub.

* Support for LLVM IR-level debugging, i.e., debugging at the level of `*.ll` instead of `*.c` files.
* New polyglot cast functions for primitive array types, which allows object from other languages to be used like primitive arrays.
* Support for function pointer members in `polyglot_as_typed`, which allows objects from other languages to be used in expressions like `obj->func(args)`.

### Ruby
The complete [changelog](https://github.com/oracle/truffleruby/blob/master/CHANGELOG.md#10-rc-6-3-september-2018) is available on GitHub. Here is a short list of most notable changes.

* TruffleRuby is now usable as a JSR 223 (`javax.script`) language;
* A [migration guide from JRuby](https://github.com/oracle/truffleruby/blob/master/doc/user/jruby-migration.md) is now included.
* The embedded configuration `-Xembedded` can now be set set on the launcher command line.
* `Polyglot.export` can now be used with primitives and converts strings to Java, when `Polyglot.import` converts them from Java.
* Foreign objects optimisations such as unboxing foreign strings on `to_s`, `to_str`, and `inspect`.
* Optimized performance and keyword rest arguments `(def foo(**kwrest))`.
* Multiple bug fixes from user reports.

### Python

The full [changelog](https://github.com/graalvm/graalpython/blob/master/CHANGELOG.md#version-100-rc6) is available on GitHub.

* Improved compatibility with regular expressions by including CPython's sre module as a fallback engine (in addition to Truffle's regular expression engine).
* C extension modules can now be compiled with LLVM 5+, which was prevented by internal incompatibilities before.
* Introduced lazy string concatenation to significantly speed up code patterns that repeatedly concatenated strings.
* Numerous C-API improvements to extend support for scikit-learn.
* Extensions and fixes in various areas: behavior of function and code objects, collections, exception handling during import, type ids, documentation and generators.
* Update standard library to CPython 3.6.5.
* Enable reuse of ASTs in multiple Contexts (requires the contexts to be created in the same polyglot Engine).

### R

The full [changelog](https://github.com/oracle/fastr/blob/master/CHANGELOG.md#10-rc-6)
is available on GitHub.

* Support for reading/writing graphical parameters via `par`.
* Added numerous builtins to the C API, enabling support for packages like RCurl, rjson, compare, naivebayes, etc.
* Added support for formulas that include `...`.
* Various bug fixes: attributes of `NULL` objects, of `CR/LF` handling in readLine, `La_chol` with pivot, warnings/errors in vector coercion.

### API Changes for GraalVM Integrators (SDK + Truffle)

To see the list of changes to the APIs please refer to the project changelogs:

* [GraalVM SDK changelog](https://github.com/oracle/graal/blob/master/sdk/CHANGELOG.md#version-10-rc6)
* [GraalVM Truffle changelog](https://github.com/oracle/graal/blob/master/truffle/CHANGELOG.md#version-100-rc6)

## 1.0-RC5
(2018-07-31)

GraalVM 1.0-rc5 is the first release where we provide **pre-built binaries for GraalVM Community on macOS**. As always all binaries are available from the [downloads page](/downloads).

**KNOWN ISSUES**

* The GraalVM Community distribution for macOS currently depends on some libraries that are not installed by default on current macOS versions.
This might cause issues with UI-related functionality:
```
Library not loaded: /usr/X11/lib/libfreetype.6.dylib
```
The necessary components can be added, e.g., by installing [https://www.xquartz.org](https://www.xquartz.org). We will remove this dependency in upcoming versions of GraalVM Community for macOS.

### GraalVM for Java Developers (GraalVM + compiler)

* 1.0-RC5 includes JVMCI changes necessary to support compiling the GraalVM compiler ahead of time and deploying as a shared library alongside `libjvm.so` (i.e., libgraal). Note that the implementation of _libgraal_ itself is not a part of this release as it is still under development.

### Native Image Generation

* Added API that allows an application to distinguish between native image building, native image runtime, and regular Java execution. For more information and documentation, look at the class  [ImageInfo](https://github.com/oracle/graal/blob/master/sdk/src/org.graalvm.nativeimage/src/org/graalvm/nativeimage/ImageInfo.java).


### JavaScript

* Removed legacy NashornExtensions option, use `--js.nashorn-compat` instead.
* Added support for `Symbol.prototype.description`.
* Added support for `String.prototype.matchAll`.

More details can be found in the [project changelog on GitHub](https://github.com/graalvm/graaljs/blob/master/CHANGELOG.md#version-100-rc5).

### Ruby
The full [changelog is available](https://github.com/oracle/truffleruby/blob/master/CHANGELOG.md#10-rc-5-3-august-2018) in the GitHub repository, but here are some of the most notable changes.

* Simpler installation on macOS: it is no longer needed to add LLVM (`/usr/local/opt/llvm@4/bin`) to PATH on macOS.
* `--log.ruby.level=` can be used to set the log level from any language launcher.
* `String#unpack1` has been implemented.
* Optimized required and optional keyword arguments.
* `-Dtruffleruby.log` and `TRUFFLERUBY_LOG` have been removed - use `-Dpolyglot.log.ruby.level`.
* The custom log levels `PERFORMANCE` and `PATCH` have been removed.

### Python

* Generator expressions now properly evaluate their first iterator in the definition scope at definition time.
* Fixes for embedders to ensure top scopes are stable and local scopes always contain TruffleObjects.
* C-API improvements to support simple Cython modules.
* Support recognition of Python source files with the polyglot launcher, so that now `--language python` is not necessary when starting Python scripts with the polyglot launcher (note that the polyglot launcher still needs to be rebuilt using `bin/gu rebuild-images polyglot` after installing Python).

Full changelog is available on GitHub [CHANGELOG.md](https://github.com/graalvm/graalpython/blob/master/CHANGELOG.md#version-100-rc5).

### R

See [CHANGELOG](https://github.com/oracle/fastr/blob/master/CHANGELOG.md#10-rc-5) for the list of changes.

### LLVM Runtime

The project [changelog](https://github.com/oracle/graal/blob/master/sulong/CHANGELOG.md#version-100-rc5) is available on GitHub.

* Support the `__builtin_debugtrap` function based on LLVM's `@llvmn.debugtrap` intrinsic, which can be used to drop into the debugger (e.g., Chrome Inspector).
* Support "zero-length array at end of struct" pattern when accessing polyglot values as structs.
* Improved performance of global variable access.
* Improved support for vectorized bitcode operations generated by clang.

### API Changes for GraalVM Integrators (SDK + Truffle)

* Added new [execution listener API](http://www.graalvm.org/sdk/javadoc/org/graalvm/polyglot/management/ExecutionListener.html) that allows for simple, efficient and fine-grained introspection of executed code.
* Changed the default language context policy from `SHARED` to `EXCLUSIVE`, i.e. by default there is one exclusive language instance per polyglot or inner context. This can be configured by the language using the [context policy](http://www.graalvm.org/truffle/javadoc/com/oracle/truffle/api/TruffleLanguage.ContextPolicy.html).

To see the full list of changes to the APIs please refer to the project changelogs:

* [GraalVM SDK changelog](https://github.com/oracle/graal/blob/master/sdk/CHANGELOG.md#version-10-rc5)
* [GraalVM Truffle changelog](https://github.com/oracle/graal/blob/master/truffle/CHANGELOG.md#version-100-rc5)

### Tools
**Graal VisualVM**
* Graal VisualVM was added to the GraalVM Community distribution.


## 1.0-RC4
(2018-07-13)
### General Remarks
While we provide updated components for all languages for this rc4 release, only the JavaScript component received fixes from its upstream repository. All other languages are unchanged in terms of functionality.

The next release, rc5, is planned for the beginning of August and will provide updates for all components.

### JavaScript

The GraalVM JavaScript component has been updated to provide better compatibility with the Nashorn engine. There now is a `--nashorn-compat` flag to enable backwards compatibility functionality. This flag is highly discouraged for new applications, but can simplify the migration from Nashorn to GraalVM for existing code.

* Access getters and setters like fields
* Provide Java.extend, Java.super, JavaImporter, JSAdapter
* Allow to construct Interfaces or AbstractClasses
* Provide top-level package globals `java`, `javafx`, `javax`, `com`, `org`, `edu`

* Provide Java.isScriptFunction, Java.isScriptObject, Java.isJavaMethod and Java.isJavaFunction

Some global functions and objects have been added for the scripting mode and can be enabled with the -`-scripting` flag:

* Provide `$EXEC`, `$ENV`, `$ARG`, `$OPTIONS`

## 1.0-RC3
(2018-06-29)
### GraalVM for Java Developers (GraalVM + compiler)

* Updated the underlying JDK version to “1.8.0_172” from “1.8.0_171”. You can find the JDK release notes at the [Oracle Technology Network](http://www.oracle.com/technetwork/java/javase/8u172-relnotes-4308893.html) website.
* Fixed a rare NullPointerException during JVMCI initialization.

### Native Image Generation

* Added support for java.lang.reflect.Proxy supporting both automatic detection and manual configuration.
* Added support for `Classloader.getResource()` and similar methods.
* Added support for loading services through `theServiceLoader`.
* Fixed a `ClassCastException` on generating native images for profile-guided-optimizations (with the `--pgo-instrument` command line option).

### JavaScript

* Enabled code sharing between Contexts with the same Engine.
* Added support for `BigInt` arithmetic expressions.
* Added a flag for the Nashorn compatibility mode `--js.nashorn-compat`, for the details and migration from Nashorn please [refer to the documentation](https://github.com/graalvm/graaljs/blob/master/docs/user/NashornMigrationGuide.md).
* Rename the flag for the V8 compatibility mode to `js.v8-compat`.

More details can be found in the [project changelog on GitHub](https://github.com/graalvm/graaljs/blob/master/CHANGELOG.md#version-100-rc3).

### Ruby

The full [changelog is available](https://github.com/oracle/truffleruby/blob/master/CHANGELOG.md#10-rc-3-2-july-2018) in the GitHub repository, but here are some of the most notable changes.

* Added ability to call `is_a?` on foreign objects.
* Fixed: Qnil/Qtrue/Qfalse/Qundef can now be used as initial value for global variables in C extensions.
* Fixed: SIGPIPE is correctly caught on SubstrateVM, and the corresponding `write()` raises `Errno::EPIPE` when the read end of a pipe or socket is closed.
* Fixed determining the source encoding for `eval()` based on the magic encoding comment.

Additionally, we implemented a number of performance improvements for `stat()` related calls, `eval()`, String substitutions, reading from IO and more.

### Python

GraalVM Python implementation is still in the early stages, but we’re making progress towards the goal of running applications which use SciPy.

* Various C-API improvements allow to run **simple NumPy examples.**
* Implemented buffered I/O and more encodings support, which enables working with files through the standard open function without having to force unbuffered access, and enables working with files that have encodings other than utf-8.
* Most math module functions are now implemented and work correctly.
* The random module substitute was removed and we now run the standard library random module to be fully compatible.
* Improved thread-safety in the embedded scenarios when using Python contexts from multiple threads.

More details are available in [the project’s changelog](https://github.com/graalvm/graalpython/blob/master/CHANGELOG.md#version-100-rc3) on GitHub.

### R

* Added more missing R builtins and C API functions, see [CHANGELOG](https://github.com/oracle/fastr/blob/master/CHANGELOG.md#10-rc-3) for a complete list.
* Simplified installation, the script that configures FastR for the current system  `jre/languages/R/bin/configure_fastr` does not require Autotools anymore.
* Added configuration files to allow users to build a native image of the FastR runtime, which reduces the startup time. Run `jre/languages/R/bin/install_r_native_image` to build the image.
* Fixed an issue with the plotting window not displaying anything after it was closed and reopened.

### LLVM Runtime

* New builtins _polyglot_from_typed_ and _polyglot_as_typed_, which can be used to dynamically attach types to polyglot objects.
* Implementers of TruffleObject can now respond to the `GetDynamicType` message to provide a type when an object is accessed from LLVM code.

More details are available in [the project changelog](https://github.com/graalvm/sulong/blob/master/CHANGELOG.md).

### API Changes for GraalVM Integrators (SDK + Truffle)

* Added support for [logging](http://www.graalvm.org/sdk/javadoc/org/graalvm/polyglot/Context.Builder.html#logHandler-java.util.logging.Handler-) in Truffle languages and instruments.
* Removed deprecated ResultVerifier.getDefaultResultVerifier API.

To see the list of changes to the APIs please refer to the project changelogs:

* [GraalVM SDK changelog](https://github.com/oracle/graal/blob/master/sdk/CHANGELOG.md#version-10-rc3)
* [GraalVM Truffle changelog](https://github.com/oracle/graal/blob/master/truffle/CHANGELOG.md#version-100-rc3)

### Tools

##### Graal VisualVM

We improved memory footprint and introduced several UI improvements for cleaner more responsive experience of Graal VisualVM. In addition to that, there are the following improvements:

* Added recognition of the LLVM Runtime processes.
* Improved displaying logical values of guest languages’ objects.
* Improved the Object Query Language (OQL) Console for inspecting memory dumps functionality — sorting, filtering, aggregation, unlimited number of results now work.

#### Chrome inspector

* Multiple inspector sessions for multiple polyglot engines can run on the same port now.

## 1.0-RC2
(2018-06-05)
### GraalVM for Java Developers
* Updated the underlying JDK version to “1.8.0_171” from “1.8.0_161”. You can find the JDK release notes at the [Oracle Technology Network](http://www.oracle.com/technetwork/java/javase/8u171-relnotes-4308888.html) website.
* Improved support for the Java Microbenchmark harness. Since JMH 1.21, GraalVM is a [recognized and supported JVM](http://mail.openjdk.java.net/pipermail/jmh-dev/2018-May/002753.html).
* Fixed a [StackOverflow exception](https://github.com/oracle/graal/issues/341) an improved performance when recursively inlining of invokedynamic instructions.
* Fixed a [compiler error](https://github.com/oracle/graal/issues/423) causing incorrect code generation while building the scalac compiler.

### Native Image Generation

* Added support for building statically linked native images. Now you can pass `--static`, and if you have static libc and zlib installed, it generates a standalone executable that will not require libc for running.
* Added Classpath exception to the license of SubstrateVM and the [Graal compiler](https://github.com/oracle/graal/blob/master/compiler/LICENSE.md) components to make sure all GraalVM code ending up in a native image is subject to this clause.
* Fixed the handling of implicit exceptions (NullPointerExeption, ArrayIndexOutOfBoundsException, ClassCastException, …): all exceptions now have correct stack traces and can be caught as expected. Previously, implicit exceptions were sometimes not caught by an exception handler within the same method.
* Fixed a number of exceptions during the generation of native images that were reported by early adopters.

### JavaScript

* Updated [Node.js to 8.11.1](https://nodejs.org/en/blog/release/v8.11.1/) (from 8.9.4), it is not a breaking change, but it brings numerous improvements, including CVE-listed security fixes.

### LLVM Runtime

* Added a new API for accessing Java types and instantiating foreign objects from LLVM languages.

Now it is possible to easily call Java code from native programs compiled to the LLVM bitcode. The example below shows how you can access Java’s BigInteger long math operations from C.

```
#include <stdio.h>
#include <polyglot.h>
int main() {
    void *bigInteger = polyglot_java_type("java.math.BigInteger");
    void *(*BigInteger_valueOf)(long) = polyglot_get_member(bigInteger, "valueOf");

    void *bi = BigInteger_valueOf(2);
    void *result = polyglot_invoke(bi, "pow", 256);

    char buffer[100];
    polyglot_as_string(polyglot_invoke(result, "toString"),
                       buffer,
                       sizeof(buffer),
                       "ascii");

    printf("%s\n", buffer);
}
```

If we compile it to the LLVM bitcode, we can execute it with GraalVM. You can see that it computes the value of2^256 which isn’t that easy to do in C otherwise.

```
# shelajev at shrimp.local in /tmp
→ clang -c -O1 -emit-llvm -I$JAVA_HOME/jre/languages/llvm big-integer-demo.c

# shelajev at shrimp.local in /tmp
→ lli --jvm big-integer-demo.bc
115792089237316195423570985008687907853269984665640564039457584007913129639936
```

A more detailed list of changes to the LLVM interpreter can be found in the [full changelog](https://github.com/oracle/graal/blob/master/sulong/CHANGELOG.md#version-100-rc2).

### Ruby

* We are now compatible with Ruby 2.4.4.
* Java.import name imports Java classes as top-level constants.
* Coercion of foreign numbers to Ruby numbers now works.
* `to_s` works on all foreign objects and calls the Java `toString`.
* `to_str` will try to UNBOX and then re-try `to_str`, in order to provoke the unboxing of foreign strings.

Much more details can be found in the full [changelog](https://github.com/oracle/truffleruby/blob/master/CHANGELOG.md#10-rc-2-6-june-2018).

### R

Among the other changes, we improved the stability of GraalVM’s R implementation.

* Added a `/jre/languages/R/bin/configure_fastr` script that allows FastR’s native build scripts to adopt to the current system, which makes installing R packages much more stable.
* The _fastr_errors.log_ file was renamed to _fastr_errors_pidXYZ.log_ and is stored in either initial working directory, the user home directory, /tmp, or the FastR home directory (picking the first location that is writeable). Please add it to the bug reports if you submit issues.

### Python

* Added support for the Python [unittest](https://docs.python.org/3/library/unittest.html) framework.
* Python now supports breaking on exceptions and unwinding to stack frames in Chrome inspector.

### API Changes for GraalVM Integrators (SDK + Truffle)

Both GraalVM SDK and Truffle are offering API for developers trying to build things on top of GraalVM, language implementations, embedding GraalVM, and so on.

* Enabled code sharing between guest language Contexts with the same Engine, speeding up the repeated evaluation of the code.

To see the list of changes to the APIs please refer to the project changelogs:

* [GraalVM SDK changelog](https://github.com/oracle/graal/blob/master/sdk/CHANGELOG.md#version-10-rc2)
* [GraalVM Truffle changelog](https://github.com/oracle/graal/blob/master/truffle/CHANGELOG.md#version-100-rc2)

### Tools

#### VisualVM
* Fixed the issues with loading polyglot heap dumps
* fixed executing of scripts in R console
* improved recognition of R REPL
* fixed `loop to` nodes
* fixed memory leak in child nodes
* improved appearance on macOS
* Applicability fixes
* added roots histogram for class

#### GraalVM Updater `gu`

* The default operation mode changed from “install from local files” to “install from catalog”.
* `-c` option for installing from the catalog, can be omitted (installing from the catalog the default), but specifying `-c` still works.
* Use `-F` to install from local files, i.e. `bin/gu -F /tmp/ruby-installable.jar`.

#### Chrome Inspector

Fixed a number of issues:

* fixed the initial suspend of node scripts with no statement on the first line
* fixed tooltip issues and representation of the functions
* fixed issues with re-connection of Chrome inspector client
