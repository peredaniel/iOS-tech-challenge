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
    + [iOS 13 and dark mode](#ios-13-and-dark-mode)
  * [Tests](#tests)
    + [Unit tests](#unit-tests)
    + [Snapshot tests](#snapshot-tests)
    + [UI tests](#ui-tests)
      - [MockServer](#mockserver)
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

Altough I am aware that here at ABA we implement views by code, in the last year almost every project I took part on did use storyboards and XIB files, which may me used to them. Therefore, I decided to use them in this assignment to further remove code from the view classes and keep them *clean* and as short as possible.

Furthermore, navigation is now driven by segues which are located in the file *Search.storyboard*, thus having a clear picture of the flow of the app.

### Dependency injection

Dependency injection to the initial view controller was already present in the original code base. We removed it as part of the initial refactor, and re-added it after the feature implementation since it was required for our UI tests (see [UI tests](#ui-tests) below).

As for the rest of the navigation, dependency injection is performed at the view model layer. That is, any dependency necessary for a view model is injected during initialization by the view model of the previous screen. The only exception are the view models of cells, which are handled by the DataSourceController framework (see [DataSourceController](#datasourcecontroller) below).

## Feature implementation

As part of this assignment we have been required to implement a new feature. The requirements, as specified in the originally included *README.md* file, read as follows:
> * Users would be able to search content by artist name and enjoy it while singing.
> * Results should be presented in a modern fashion way.
> * Usability is a most for us and we would like to have a fresh user experience.

With these requirements in mind, we outlined the specifications for our task development:
* Home screen must not rotate (only portrait mode is available).
* Search must be performed in the home screen using the native `UISearchBar` from `UIKit`.
* Search bar must always be visible, not hiding under any circumstance.
* Search bar must be the focus when the app first starts (that is, the keyboard is deployed and the user may type in directly) and whenever the screen loads (even from a "back" navigation).
* Search must have three scopes: *artist* (by requirement), *album* and *song*. These scopes must be presented as part of the search bar using the native API of `UISearchBar` component.
* Search results must be updated automatically as the user types in into the search bar or changes the search scope. A delay of 0.5 seconds must be respected between the last key stroke and the search execution to avoid performing unnecessary calls to the backend.
* Search results (tracks) must be grouped by artist, and artists must be displayed in *alphabetical* order in a list.
* Tracks belonging to the same artist must be presented as a *horizontal rail*.
* In case of error, an alert must be displayed to inform the user. A single button to close the alert must be included.
* In case of a result not returning any result, the user must be informed without disturbing normal app usage (so, no alerts).
* Details screen must play the video music preview automatically and stop when it ends. No controls must be displayed in the player.
* Details sceen must enable rotation to landscape.

These requirements lead to the final implementation and design that we show in the following GIF:

<img src="Tour.gif" width="300">

### iOS 13 and dark mode

An important note, not included in the requirements, is that we raised the deployment target to iOS 13.0 or higher. The reasoning behind this is that iOS 13 included a lot of API changes, mainly due to the addition of *dark mode* in iOS, and therefore it was simpler to raise the deployment target to that version rather than handling every single non-compatible API invoked.

As a consequence, it is worth mentioning that the app is compatible with dark mode. Don't hesitate on giving it a try by [turning on dark mode in the simulator!](https://technikales.com/how-to-turn-on-dark-mode-in-ios-13-simulator/)

## Tests

Although both the unit tests and the UI tests target were already included in the original code base, there were no tests implemented besides the default empty tests that are created when the test bundles are added to a Xcode project. We extensively expanded both testing targets to raise code coverage to nearly 100% and cover several user journeys when using this section of the app.

### Unit tests

Unit tests are tests of isolated components or business logic using mock objects. Therefore, as a general basis, at the very least every view model should include unit tests when using the MVVM architecture. Furthermore, when using repositories in Android Clean Architecture, all of the repositories should include unit tests too. Therefore we have implemented unit tests for the following components:
* Mappers from server model object `SearchResponse` to domain model objects `Artist` and `Track`
* Repository `SearchRepository`
* View models `HomeViewModel`, `SearchResultCollectionViewModel`, `SearchResultTableViewModel`, `TrackDetailsViewModel` and `TrackPlayerViewModel`.

As usual, all of these tests use mock objects to pass data or receive delegate calls and perform validations.

### Snapshot tests

By means of the framework **SnapshotTesting** (see [the corresponding section](#snapshottesting) below) we included snapshot tests of almost every view in the app, from the simplest cell to a whole view controller. In particular, we implemented snapshot tests for the following classes:
* `HomeViewController`
* `TrackDetailsViewController`
* `SearchResultCollectionCell`
* `SearchResultTableCell`
* `EdgeInsetLabel`

The only view without snapshot tests is the *TrackPlayerViewController*, which is a straighforward subclass of *AVPlayerViewController* and we considered unnecessary since it's usage is already covered by UITests.

Snapshots can be found in the subfolders of `ABA MusicTests/Source/Views tests/__Snapshots__/`.

### UI tests

Contrary to unit tests, UITests run the app and perform an already implemented set actions from the point of view of a user. Therefore, there is no access to the code: we can only access to what is on screen. Bearing this in mind, we used UITests to test user journeys in several use cases. In particular, we grouped the UITests as follows:
* **ApplicationUITests**: These are general tests with a non-specific scope. In this case, there is a single UITest to run the app until we reach the home screen. This is to make sure that the app normal initialization process does not brake when introducing changes.
* **NavigationUITests**: These are tests devoted to navigation between different screens. No feature is tested in these tests unless it is necessary to trigger the navigation. In this case, we implemented the navigation from the home screen to the track details screen and back to the home screen in all three search scopes: artist, song and album. They also include device rotation while in the track details screen.
* **SearchUITests**: These are the particular UITests for the search feature. They include several scenarios, including:
  - Perform a search and obtain an error. Then perform a search again and obtain a successful response (in all three search scopes).
  - Perform a search and obtain a successful *empty* response (in all three search scopes).
  - Perform a search and obtain a successful *non-empty* response (in all three search scopes).
  - Perform a search and obtain a successful *non-empty* response. Then change scope and obtain a new successful *non-empty* response without changing search term (in all possible combinations: artist -> song, artist -> album, song -> artist, song -> album, album -> artist and album -> song).
  - Perform a search and obtain a successful *non-empty* response. Then perform a new search and obtain a new successful *non-empty* response (in all three search scopes).

Of course, there are more scenarios to take into account, but most will be combinations of the above.

#### MockServer

Using [Swifter](#swifter)'s `HttpServer` class as a basis we implemented a `MockServer` which enables us to register JSON responses to a specific endpoint and get those responses when the app performs a "remote" call to that endpoint. Furthermore, the endpoint response may be modified at runtime, and therefore this class behaves as a real server running in our localhost.

In our subclass we added some helper functions and struct to easily register responses and log a detailed warning message in the debugger when a response is missing from the mock server. Note that you may not need to register every response to the mock server if your tests aren't using it, and thus a missing response does not stop the test execution unless the user journey is blocked by the missing data. The complete implementation may be found in the files `MockServer.swift` and `HttpStubInfo.swift` within the `ABA MusicUITests/MockServer` folder.

The only catch to use this `MockServer` class (and, in general, the `HttpServer` from Swifter) is that we must set our app to perform calls only to `http://localhost` (to any port we specify). Therefore, there are several points to take into account:
* We must open our app to use a non-secure connection in our localhost (since it's `http` and not `https`). This is usually not a problem, but it must be considered.
* We must implement some way to change the base url of our remote calls to `http://localhost` **only** when running UITests.

## Third-party frameworks

Since the frameworks were not included in the original repository, one of the first things we had to do is perform a `pod install --repo-update` in the root folder to install dependencies. After that, we reviewed all the dependencies included in the `Podfile` and their usage in the code. As a consequence, we remove all of the dependencies except for `AlamofireImage`, which was the only one under use.

During the implementation of the search feature and the tests we decided to use some additional dependencies, which we discuss in the following.

**Note:** The `Pods/` folder in now checked into the repository, so that we can just download and press `Run` to execute the app in the simulator.

### AlamofireImage

`AlamofireImage` is a library that enables to easily manage downloading and setting images from the internet. It has a simple and clear API, and includes a built-in cache system to avoid downloading the same image again and again.

**Source:** [https://github.com/Alamofire/AlamofireImage](https://github.com/Alamofire/AlamofireImage)

### DataSourceController

`DataSourceController` is an OpenSource library developed and maintained by myself which provides an implementation of both `UITableViewDataSource` and `UICollectionViewDataSource`. In addition, it provides a more declarative API by using `Section` instances to defines the list sections. It enables us to remove a lot of boilerplate code from our classes by removing the conformance to the above mentioned protocols.

**Source:** [https://github.com/peredaniel/DataSourceController](https://github.com/peredaniel/DataSourceController/)

### SnapshotTesting

`SnapshotTesting` is a library similar to [iOSSnapshotTestCase](https://github.com/uber/ios-snapshot-test-case) (formerly maintained by Facebook, now maintained by Uber) developed by the awesome team of Point-Free. Contratry to `iOSSnapshotTestCase`, `SnapshotTesting` is written purely in Swift and is compatible with [Nimble](https://github.com/Quick/Nimble) using a plugin.

This library enables us to snapshot test views, server responses and more in several formats, from images to plain text files, which makes it outstandingly versatile.

**Source:** [https://github.com/pointfreeco/swift-snapshot-testing](https://github.com/pointfreeco/swift-snapshot-testing)

### Swifter

`Swifter` is a library providing a tiny http server engine written in Swift. Documentation is short at the very best in their GitHub, but the repository does include several examples and use cases which are really helpful. This is the base for the [MockServer](#mockserver) class introduced previously.

**Source:** [https://github.com/httpswift/swifter](https://github.com/httpswift/swifter)

## Tools

In addition to the feature implementation, the code refactor and the tests implementation, we added several tools to the repository which helped us during this assignment.

### Continuous Integration server

Since this repository is *public* (since it's forked from a *public* repository), we created a Travis CI instance attached to it to run tests and perform additional tasks automatically. In combination with our [Branching strategy](#branching-strategy) and some protection rules on `master` and `develop`, we ensure that no code was ever merged to these branches without passing the proper tests.

The current jobs and triggers are the following:
- **Compile**: Just compiles the app. This job is executed when a PR to `master` or `develop` is opened, to prevent merging any change that breaks the app build. If this job fails, no further jobs are executed.
- **Run unit tests**: Runs the unit tests suite. This job is executed when a PR to `master` or `develop` is opened.
- **Run UI tests**: Runs the UI tests suite. This job is executed when a PR to `master` or `develop` is opened.
- **Gather code coverage data**: Runs the complete tests suites. If all test succeed, the coverage data is uploaded to Coveralls using Slather (see [Code coverage reports](#code-coverage-reports) below). This job is executed when a commit is pushed to either `master` or `develop`. Note that since both braches are protected and only pushes by means of PRs are allowed, tests should always succeed (since they must succeed to enable merging).

You may take a look at all the jobs execute, and to the Travis CI instance, by following this link: [https://travis-ci.com/peredaniel/iOS-tech-challenge](https://travis-ci.com/peredaniel/iOS-tech-challenge)

### Code coverage reports

Since this repository is *public* (since it's forked from a *public* repository), we created a Coveralls instance attached to it to gather code coverage data and display it as a report. This code coverage data is generate automatically by Xcode when running tests, and gathered and uploaded to Coveralls using [Slather](https://github.com/SlatherOrg/slather).

You may take a look at the code coverage reports for `master` in Coveralls by following this link: [https://coveralls.io/github/peredaniel/iOS-tech-challenge](https://coveralls.io/github/peredaniel/iOS-tech-challenge)

## Branching strategy

GitFlow variant: [https://datasift.github.io/gitflow/IntroducingGitFlow.html](https://datasift.github.io/gitflow/IntroducingGitFlow.html)

Active branches: [https://github.com/peredaniel/iOS-tech-challenge/branches/active](https://github.com/peredaniel/iOS-tech-challenge/branches/active)

Pull requests: [https://github.com/peredaniel/iOS-tech-challenge/pulls?q=is%3Apr+is%3Aclosed](https://github.com/peredaniel/iOS-tech-challenge/pulls?q=is%3Apr+is%3Aclosed)

## Further improvements

### Lyrics

### Local storage

### Favorites
