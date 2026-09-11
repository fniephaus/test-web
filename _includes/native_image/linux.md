// BEGIN-SNIPPET
On Oracle Linux use the YUM package manager:

```shell
$ sudo yum install gcc glibc-devel zlib-devel
```

Some Linux distributions may additionally require libstdc++-static.
You can install libstdc++-static if the optional repositories are enabled (_ol7_optional_latest_ on Oracle Linux 7 and _ol8_codeready_builder_ on Oracle Linux 8).

On Ubuntu Linux use the `apt-get` package manager:

$ sudo apt-get install build-essential zlib1g-dev

On other Linux distributions use the DNF package manager:

$ sudo dnf install gcc glibc-devel zlib-devel libstdc++-static

// END-SNIPPET