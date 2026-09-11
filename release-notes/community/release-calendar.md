---
layout: toc_content_ecosystem
title: GraalVM Release Calendar
link_title: GraalVM Release Calendar
permalink: "/release-calendar/"
toc_group: release-notes
---

# GraalVM Release Calendar

Prior to September 2025, releases were labeled "GraalVM for JDK &lt;version&gt;" (for example, GraalVM for JDK 21); since then they use the simpler "GraalVM &lt;version&gt;" format.

**Feature Release**

Starting with the 25.1 release line, GraalVM Community Edition and Oracle GraalVM provide innovation (feature) releases on a monthly cadence with quarterly CPUs incorporated when available.
Previously, feature releases were shipped every six months, with each release receiving two quarterly Critical Patch Updates (CPUs) before being superseded by the next feature release.

The most recent feature release supersedes all previous feature releases.

**Weekly Early Access (EA)** builds for feature releases continue to be published so you can preview and provide feedback before each general availability (GA) release.

**Critical Patch Update (CPU)**

Critical Patch Updates (CPUs) for Oracle GraalVM are published on the third Tuesday of January, April, July, and October, in line with the Oracle CPU release schedule.
Starting with 25.1, GraalVM feature releases are published on the Tuesday of the following week to allow additional time for testing.

All active releases receive patch updates.

## Planned Releases

| Date               | Type          | Oracle GraalVM                   | GraalVM Community Edition | GraalPy (Python version) |
|--------------------|---------------|----------------------------------|---------------------------|--------------------------|
| September 22, 2026 | Feature       | 25.4.4                           | 25.4.4                    | 25.4.4 (3.13)            |
| October 20, 2026   | CPU           | 17.0.21, 21.0.13, 25.0.5         | -                         | -                        |
| October 27, 2026   | Feature + CPU | 25.5.5                           | 25.5.5                    | 25.5.5 (3.14*)           |
| November 24, 2026  | Feature       | 25.6.5                           | 25.6.5                    | 25.6.5 (3.14*)           |
| January 19, 2027   | CPU           | 17.0.22, 21.0.14, 25.0.6	        | -                         |  -                       |
| January 26, 2027   | Feature + CPU | 25.7.6                           | 25.7.6                    | 25.7.6 (3.14*)           |
| February 23, 2027  | Feature       | 25.8.6                           | 25.8.6                    | 25.8.6 (3.14*)           |

\* GraalPy supports a new Python version once it enters the security-fix phase. See [Python versions](https://devguide.python.org/versions/) for the Python release schedule.

### Understanding Release Numbering

GraalVM follows the JDK version numbering scheme described in [JEP 223](https://openjdk.org/jeps/223) (MAJOR.MINOR.SECURITY).
The **MAJOR** number indicates the Java language specification baseline.
The **MINOR** number indicates the feature release train, such as 25.1, 25.2, and so on.
The **SECURITY** number indicates the CPU level of the underlying JDK update.
For example, GraalVM 25.1.**3**, released on June 25, 2026, corresponds to the third CPU level.

## Previous Releases

| Date               | Type          | Oracle GraalVM           | GraalVM Community Edition | Graal Languages |
|--------------------|---------------|--------------------------|---------------------------|-----------------|
| August 25, 2026    | Feature       | 25.3.4.1                 | 25.3.4.1                  | 25.3.4.1 (3.13) |
| July 28, 2026      | Feature + CPU | 25.2.4                   | 25.2.4                    | 25.2.4 (3.12)   |
| July 21, 2026      | CPU           | 17.0.20, 21.0.12, 25.0.4 | -                         | -               |
| June 30, 2026      | Feature       | 25.1.3                   | 25.1.3                    | 25.1.3 (3.12)   |
| April 21, 2026     | CPU           | 17.0.19, 21.0.11, 25.0.3 | -                         | 25.0.3          |
| January 20, 2026   | CPU           | 17.0.18, 21.0.10, 25.0.2 | 25.0.2                    | 25.0.2          |
| October 21, 2025   | CPU           | 17.0.17, 21.0.9, 25.0.1  | 25.0.1                    | 25.0.1          |
| September 16, 2025 | Feature       | 25                       | 25                        | 25.0.0          |
| July 15, 2025      | CPU           | 17.0.16, 21.0.8, 24.0.2  | 24.0.2                    | 24.2.2          |
| April 15, 2025     | CPU           | 17.0.15, 21.0.7, 24.0.1  | 24.0.1                    | 24.2.1          |
| March 18, 2025     | Feature       | 24                       | 24                        | 24.2.0          |
| January 21, 2025   | CPU           | 17.0.14, 21.0.6, 23.0.2  | 23.0.2                    | 24.1.2          |
| October 15, 2024   | CPU           | 17.0.13, 21.0.5, 23.0.1  | 23.0.1                    | 24.1.1          |
| September 17, 2024 | Feature       | 23                       | 23                        | 24.1.0          |
| July 16, 2024      | CPU           | 17.0.12, 21.0.4, 22.0.2  | 22.0.2                    | 24.0.2          |
| April 16, 2024     | CPU           | 17.0.11, 21.0.3, 22.0.1  | 22.0.1                    | 24.0.1          |
| March 19, 2024     | Feature       | 22                       | 22                        | 24.0.0          |
| January 16, 2024   | CPU           | 17.0.10, 21.0.2          | 21.0.2                    | 23.0.3, 23.1.2  |
| October 24, 2023   | CPU           | 17.0.9, 21.0.1           | 17.0.9, 21.0.1            | 23.0.2, 23.1.1  |
| September 19, 2023 | Feature (LTS) | 21                       | 21                        | 23.1.0          |
| July 25, 2023      | CPU           | 17.0.8, 20.0.2           | 17.0.8, 20.0.2            | -               |
| June 13, 2023      | Feature (LTS) | 17.0.7, 20.0.1           | 17.0.7, 20.0.1            | -               |

### GraalVM Enterprise and Community Editions

> Prior to 2023, GraalVM release numbering was based on the calendar year, for example, GraalVM Enterprise Edition 19.x, GraalVM Community Edition 20.x, and so on.

| Date              | Type         | GraalVM Enterprise Edition | GraalVM Community Edition |
|-------------------|--------------|----------------------------|---------------------------|
| July 21, 2026     | CPU          | 21.3.19                    | -                         |
| April 21, 2026    | CPU          | 21.3.18                    | -                         |
| January 20, 2026  | CPU          | 21.3.17                    | -                         |
| October 21, 2025  | CPU          | 21.3.16                    | -                         |
| July 15, 2025     | CPU          | 21.3.15                    | -                         |
| April 15, 2025    | CPU          | 21.3.14                    | -                         |
| January 21, 2025  | CPU          | 20.3.17, 21.3.13           | -                         |
| October 15, 2024  | CPU          | 20.3.16, 21.3.12           | -                         |
| July 16, 2024     | CPU          | 20.3.15, 21.3.11           | -                         |
| April 16, 2024    | CPU          | 20.3.14, 21.3.10           | -                         |
| January 16, 2024  | CPU          | 20.3.13, 21.3.9, 22.3.5    | -                         |
| October 17, 2023  | CPU          | 20.3.12, 21.3.8, 22.3.4    | -                         |
| July 18, 2023     | CPU          | 20.3.11, 21.3.7, 22.3.3    | -                         |
| April 18, 2023    | CPU          | 22.3.2, 21.3.6, 20.3.10    | 22.3.2                    |
| January 17, 2023  | CPU          | 22.3.1, 21.3.5, 20.3.9     | 22.3.1                    |
| October 18, 2022  | Feature, CPU | 22.3.0, 21.3.4, 20.3.8     | 22.3.0                    |
| July 19, 2022     | Feature, CPU | 22.2.0, 21.3.3, 20.3.7     | 22.2.0, 21.3.3            |
| April 19, 2022    | Feature, CPU | 22.1.0, 21.3.2, 20.3.6     | 22.1.0, 21.3.2, 20.3.6    |
| January 18, 2022  | Feature, CPU | 22.0.0, 21.3.1, 20.3.5     | 22.0.0, 21.3.1, 20.3.5    |
| October 19, 2021  | Feature, CPU | 21.3.0 (LTS), 20.3.4       | 21.3.0, 20.3.4            |
| July 20, 2021     | Feature, CPU | 21.2.0, 20.3.3             | 21.2.0, 20.3.3            |
| April 20, 2021    | Feature, CPU | 21.1.0, 20.3.2, 19.3.6     | 21.1.0, 20.3.2, 19.3.6    |
| January 19, 2021  | Feature, CPU | 21.0.0, 20.3.1, 19.3.5     | 21.0.0, 20.3.1, 19.3.5    |
| November 17, 2020 | Feature      | 20.3.0 (LTS)               | 20.3.0                    |
| October 20, 2020  | CPU          | 20.2.1, 19.3.4             | 20.2.1, 19.3.4            |
| August 18, 2020   | Feature      | 20.2.0                     | 20.2.0                    |
| July 14, 2020     | CPU          | 20.1.1, 19.3.3             | 20.1.1, 19.3.3            |
| May 19, 2020      | Feature      | 20.1.0                     | 20.1.0                    |
| April 14, 2020    | CPU          | 20.0.1, 19.3.2             | 20.0.1, 19.3.2            |
| February 18, 2020 | Feature      | 20.0.0                     | 20.0.0                    |
| January 14, 2020  | CPU          | 19.3.1                     | 19.3.1                    |
| November 19, 2019 | Feature      | 19.3.0                     | 19.3.0                    |
| October 15, 2019  | CPU          | 19.2.1                     | 19.2.1                    |
| August 20, 2019   | Feature      | 19.2.0                     | 19.2.0                    |
| July 16, 2019     | CPU          | 19.1.1                     | 19.1.1                    |
| June 11, 2019     | Feature      | 19.1.0                     | 19.1.0                    |
| May 9, 2019       | Early Access | 19.0.0                     | 19.0.0                    |

### For Contributors

Consult the [GraalVM Community Roadmap](https://github.com/orgs/oracle/projects/6/views/1) on GitHub to discover what features are currently in development as well as what to expect from upcoming releases.
Items on the roadmap are sorted by focus area and labels, and represented by GitHub issues that typically include goals, non-goals, and additional details.
