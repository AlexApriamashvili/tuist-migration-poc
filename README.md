# Tuist Migration PoC

This repository contains an example configuration of an iOS project that simulates a real-world application and illustrates the use cases of migrating to [tuist](https://tuist.io/).

Below is a brief description of the project configuration.

## Configuration

The project consists of:

* The main application executable (`App`)
* An integrated SPM package (`Common`), with three targets:
    * `Common` (also a library product), which contains logic for accessing resource bundles and references the build-tool plug-in.
    * `CommonTestingSupport` (also a library product), which contains a mock implementation of the protocol declared in `Common`.
    * `CommonTests` – a testing target that depends on both `Common` and `CommonTestingSupport`.
* The main application testing bundle depends on the `CommonTestingSupport`.

