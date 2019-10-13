# iOS Tech Challenge

<!-- **TODO: Change badges to point to master branch** -->

[![Build Status](https://travis-ci.com/peredaniel/iOS-tech-challenge.svg?branch=develop)](https://travis-ci.com/peredaniel/iOS-tech-challenge)
[![Coverage Status](https://coveralls.io/repos/github/peredaniel/iOS-tech-challenge/badge.svg?branch=develop)](https://coveralls.io/github/peredaniel/iOS-tech-challenge)
[![OS Version: iOS 13.0](https://img.shields.io/badge/iOS-13.0-green.svg)](https://www.apple.com/es/ios/ios-13/)

In this manuscript we explain and discuss the changes that have been implemented, along with some additional tools that have been added to the project or the repository.

## Table of contents

- [iOS Tech Challenge](#ios-tech-challenge)
  * [Table of contents](#table-of-contents)
  * [Code refactor](#code-refactor)
    + [Code styling](#code-styling)
    + [Architecture and design pattern](#architecture-and-design-pattern)
    + [Storyboards and XIB files](#storyboards-and-xib-files)
    + [Dependency injection](#dependency-injection)
  * [Feature implementation](#feature-implementation)
    + [Home screen](#home-screen)
    + [Track details screen](#track-details-screen)
  * [Tests](#tests)
    + [Unit tests](#unit-tests)
    + [Snapshot tests](#snapshot-tests)
    + [UI tests](#ui-tests)
  * [Third-party frameworks](#third-party-frameworks)
    + [AlamofireImage](#alamofireimage)
    + [DataSourceController](#datasourcecontroller)
    + [SnapshotTesting](#snapshottesting)
    + [Swifter](#swifter)
  * [Tools](#tools)
    + [Continuous Integration server](#continuous-integration-server)
    + [Code coverage reports](#code-coverage-reports)
  * [Branching strategy](#branching-strategy)
  * [Further improvements](#further-improvements)

## Code refactor

As a first step prior to the implementation of the requested feature we analyzed the code provided to create a list of tasks to be performed. The code analysis proved that a huge code refactor was necessary before being able to use good practices and clean code architectures during the feature implementation. In the following we detail which particular tasks were performed as part of the code refactor.

### Code styling

The original code base lacked of a homogeneous code style. Therefore, our first step in the refactor consisted in choosing a code style guide to use, and then refactor the code to conform to it. Since it's already a standard used by most developers, we chose the Swift code style guide from Ray Wenderlich which can be found [here](https://github.com/raywenderlich/swift-style-guide), with a minor exception in the [Spacing](https://github.com/raywenderlich/swift-style-guide#spacing) section: we use **4 spaces** instead of 2 to indent.

In addition, we have been running [SwiftFormat](https://github.com/nicklockwood/SwiftFormat) locally at least once a day to make sure that our code followed the aforementioned guidelines.

### Architecture and design pattern

### Storyboards and XIB files

### Dependency injection

## Feature implementation

### Home screen

### Track details screen

## Tests

### Unit tests

### Snapshot tests

### UI tests

## Third-party frameworks

### AlamofireImage

[https://github.com/Alamofire/AlamofireImage](https://github.com/Alamofire/AlamofireImage)

### DataSourceController

[https://github.com/peredaniel/DataSourceController/](https://github.com/peredaniel/DataSourceController/)

### SnapshotTesting

[https://github.com/pointfreeco/swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing)

### Swifter

[https://github.com/httpswift/swifter](https://github.com/httpswift/swifter)

## Tools

### Continuous Integration server

Travis CI instance: [https://travis-ci.com/peredaniel/iOS-tech-challenge](https://travis-ci.com/peredaniel/iOS-tech-challenge)

### Code coverage reports

Coveralls instance: [https://coveralls.io/github/peredaniel/iOS-tech-challenge](https://coveralls.io/github/peredaniel/iOS-tech-challenge)

## Branching strategy

GitFlow variant: [https://datasift.github.io/gitflow/IntroducingGitFlow.html](https://datasift.github.io/gitflow/IntroducingGitFlow.html)

Active branches: [https://github.com/peredaniel/iOS-tech-challenge/branches/active](https://github.com/peredaniel/iOS-tech-challenge/branches/active)

Pull requests: [https://github.com/peredaniel/iOS-tech-challenge/pulls?q=is%3Apr+is%3Aclosed](https://github.com/peredaniel/iOS-tech-challenge/pulls?q=is%3Apr+is%3Aclosed)

## Further improvements
