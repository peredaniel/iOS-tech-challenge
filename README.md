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
      - [Service and repository layer](#service-and-repository-layer)
      - [MVVM architecture](#mvvm-architecture)
      - [A comment on reactive programming](#a-comment-on-reactive-programming)
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
    + [Lyrics](#lyrics)
    + [Local storage](#local-storage)
    + [Favorites](#favorites)

## Code refactor

As a first step prior to the implementation of the requested feature we analyzed the code provided to create a list of tasks to be performed. The code analysis proved that a huge code refactor was necessary before being able to use good practices and clean code architectures during the feature implementation. In the following we detail which particular tasks were performed as part of the code refactor.

### Code styling

The original code base lacked of a homogeneous code style. Therefore, our first step in the refactor consisted in choosing a code style guide to use, and then refactor the code to conform to it. Since it's already a standard used by most developers, we chose the Swift code style guide from Ray Wenderlich which can be found [here](https://github.com/raywenderlich/swift-style-guide), with a minor exception in the [Spacing](https://github.com/raywenderlich/swift-style-guide#spacing) section: we use **4 spaces** instead of 2 to indent.

In addition, we have been running [SwiftFormat](https://github.com/nicklockwood/SwiftFormat) locally at least once a day to make sure that our code followed the aforementioned guidelines.

### Architecture and design pattern

Next step in our refactor consisted in adding some architecture. The original code base used a standard MVC design pattern, with just two view controllers which handled all the view interaction, business logic and backend calls. This made really difficult to understand what was going on, so we wanted to use some modern design pattern to split responsabilities and concerns. We finally decided to use **Model-View-ViewModel** architecture, adding the repositories with use cases and service layers from Android Clean Architecture.

#### Service and repository layers

Our first goal consisted in removing the backend calls from the view controllers and create a devoted layer for them. For this, we created two layers:
* Service layer: The services are responsible for calling and notify to whoever is using them of the success or failure of the call, additionally returning the fetched data or the error, if any.
* Repository layer: The repositories contain use cases of the functions implemented in the service layer, and are responsible for calling those function and convert the model objects returned by the services into *domain* model objects.

In addition, we implemented a new class of model object, `SearchResponse`, which was the model returned from the services. The previously implemented model objects, `Artist` and `Track`, were converted into domain model objects to which the `SearchResponse` could be mapped.

With these changes, the usage of network calls is summarized as follows:

1. A use case implemented in a repository is invoked somewhere in the code (we don't care by who).
2. The repository invokes the corresponding service function with the necessary parameters to execute the backend call.
3. The service create the necessary request and performs the remote task.
4. When the remote task completes, wether with success or failure, the service relays the result to the repository along with any data downloaded parsed into some model object or error message triggered.
5. The repository receives the response from the service and relays it to whoever invoked the use case. If any object is attached, the repository converts the model object into a domain model object.

#### MVVM architecture

Our next step after implementing the service and repository layers consisted in adopting a MVVM design pattern and refactor the code accordingly. This task included the implementation of view model classes for any view or view controller in the app, and move any logic not directly related to view creation, view refresh or user interaction handling to the view model. In particular, the following classes were added:
* `HomeViewModel` for the `HomeViewController` (formerly the `ViewController` class).
* `TrackDetailsViewModel` for the `TrackDetailsViewController` (formerly the `TrackViewController` class).
* `TrackPlayerViewModel` for the `TrackPlayerViewController` (a new view controller to replace the previous `PlayerView`).
* `SearchResultTableViewModel` for the `SearchResultTableCell` (formerly the `ArtistCollectionViewCell` class).
* `SearchResultCollectionViewModel` for the `SearchResultCollectionCell` (formerly the `TrackCollectionViewCell` class).

As usual in MVVM pattern, the views notify their view models of any user interaction, the view models perform the corresponding actions and request the views to refresh via delegate (if necessary). As a consequence, several new delegates were created to handle the two-way communication.

#### A comment on reactive programming

We gave a deep thought on wether to use reactive programming or not during this assignment. We finally decided against it for several reasons:
* Most Reactive programming frameworks (mainly [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa) and [RxSwift](https://github.com/ReactiveX/RxSwift)) are **huge** dependencies that increase either the repository size (if checked into the repository) or the build time due to the download and setup process (if not). When using a CI server, the running time is increased by a large amount if not cached.
* This assignment is a tiny app, which would not benefit much (or not at all) from these frameworks. In fact, there are just a couple of places in the code which would really benefit from a reactive approach: the single service performing asynchronous calls and the tapping of a collection view cell in the home screen (which currently relays the action through two delegates). Nevertheless, completion blocks and delegate do already cover our needs in both cases, respectively.
* [Combine](https://developer.apple.com/documentation/combine/), which is Apple's reactive framework, was released just a few months ago. Although it seems to be a good alternative to the above mentioned frameworks, I am honestly not familiar enough with it to include it in a code that should be production ready as this assignment required.

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

### Lyrics

### Local storage

### Favorites
