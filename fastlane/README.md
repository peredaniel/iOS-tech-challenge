fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
### unit_test
```
fastlane unit_test
```
Runs app's unit tests in the specified device.

Usage example: fastlane unit_test device:'iPhone 8' ios_version:'12.4'
### ui_test
```
fastlane ui_test
```
Runs app's UI tests in the specified device.

Usage example: fastlane ui_test device:'iPhone 8' ios_version:'12.4'
### full_test
```
fastlane full_test
```
Runs app's full test suite in the specified device.

Usage example: fastlane full_test device:'iPhone 8' ios_version:'12.4'
### compile_app
```
fastlane compile_app
```
Builds the app for the specified iOS version.

This lane is to make sure that the app builds correctly and that breaking API changes are detected before deployment.

Usage example: fastlane build_app ios_version:'12.4'

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
