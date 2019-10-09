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

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
