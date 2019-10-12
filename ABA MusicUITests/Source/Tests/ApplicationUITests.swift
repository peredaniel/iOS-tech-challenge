import XCTest

class ApplicationUITests: BaseUITestCase {
    func testApplicationLoadsSuccessfully() {
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Application did not load to home screen!")
        XCTAssertTrue(application.staticTexts["welcomeLabel"].waitForExistence(timeout: 5), "Application did not load to home screen!")
    }
}
