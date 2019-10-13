import XCTest

class BaseUITestCase: XCTestCase {
    let mockServer = MockServer()
    let application = XCUIApplication()
    var isRealDevice: Bool {
        return ProcessInfo.processInfo.environment["SIMULATOR_DEVICE_NAME"] == nil
    }

    override func setUp() {
        super.setUp()
        mockServer.setUp()
        continueAfterFailure = false
        launchApp()
    }

    func launchApp() {
        application.launchEnvironment["RUNNING_UI_TESTS"] = "1"
        application.launch()
    }

    func relaunchApp() {
        application.terminate()
        application.activate()
    }

    override func tearDown() {
        print(XCUIApplication.debugDescription())
        mockServer.tearDown()
        application.terminate()
        super.tearDown()
    }
}

extension XCUIElement {
    func clearText() {
        guard let stringValue = value as? String, !stringValue.isEmpty else {
            return
        }
        let deleteString = String(
            repeating: XCUIKeyboardKey.delete.rawValue,
            count: stringValue.count
        )
        typeText(deleteString)
    }
}
