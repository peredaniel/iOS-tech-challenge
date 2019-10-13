import XCTest

class NavigationUITests: BaseUITestCase {
    func testNavigationWhenSearchingByArtist() {
        mockServer.addMockedResponse(SearchStub.Artist.beatles)
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Application did not load to home screen!")
        application.searchFields.firstMatch.typeText("Beatles")
        XCTAssertTrue(application.staticTexts["The Beatles"].waitForExistence(timeout: 5), "Failed to load search results")

        application.tables.firstMatch.cells.firstMatch.staticTexts["Help!"].tap()
        XCTAssertTrue(application.otherElements["Video"].waitForExistence(timeout: 5), "Failed to load track details screen")
        XCTAssertTrue(application.staticTexts["Help!"].waitForExistence(timeout: 5), "Failed to load track details screen")
        XCTAssertTrue(application.staticTexts["The Beatles"].waitForExistence(timeout: 5), "Failed to load track details screen")
        XCTAssertTrue(application.staticTexts["Genre: Rock"].waitForExistence(timeout: 5), "Failed to load track details screen")
        XCTAssertTrue(application.staticTexts["Country: USA"].waitForExistence(timeout: 5), "Failed to load track details screen")
        XCTAssertTrue(application.staticTexts["Release date: June 22, 2018"].waitForExistence(timeout: 5), "Failed to load track details screen")

        XCUIDevice.shared.orientation = .landscapeLeft

        XCTAssertFalse(application.staticTexts["Help!"].isHittable, "Failed to load track details screen")
        XCTAssertFalse(application.staticTexts["The Beatles"].isHittable, "Failed to load track details screen")
        XCTAssertFalse(application.staticTexts["Genre: Rock"].isHittable, "Failed to load track details screen")
        XCTAssertFalse(application.staticTexts["Country: USA"].isHittable, "Failed to load track details screen")
        XCTAssertFalse(application.staticTexts["Release date: June 22, 2018"].isHittable, "Failed to load track details screen")

        XCUIDevice.shared.orientation = .portrait

        XCTAssertTrue(application.buttons.firstMatch.waitForExistence(timeout: 5), "A 'back' button should be available")
        application.buttons.firstMatch.tap()
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Failed to pop to home screen")
    }

    func testNavigationWhenSearchingByAlbum() {
        mockServer.addMockedResponse(SearchStub.Album.emptyResponse)
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Application did not load to home screen!")
        application.segmentedControls.firstMatch.buttons["Album"].tap()
        XCTAssertTrue(application.segmentedControls.firstMatch.buttons["Album"].isSelected, "'Album' search scope should be selected")

        mockServer.addMockedResponse(SearchStub.Album.rebirth)
        application.searchFields.firstMatch.tap()
        application.searchFields.firstMatch.typeText("Rebirth")
        XCTAssertTrue(application.staticTexts["DJ Spooky & Kronos Quartet"].waitForExistence(timeout: 5), "Failed to load search results")
        application.staticTexts["DJ Spooky & Kronos Quartet"].tap()
        XCTAssertFalse(application.keyboards.firstMatch.waitForExistence(timeout: 2), "Keyboard was not dismissed when supposed to")

        application.tables.firstMatch.cells.firstMatch.staticTexts["Rebirth of a Nation"].tap()
        XCTAssertTrue(application.otherElements["Video"].waitForExistence(timeout: 5), "Failed to load track details screen")
        XCTAssertTrue(application.staticTexts["Rebirth of a Nation"].waitForExistence(timeout: 5), "Failed to load track details screen")
        XCTAssertTrue(application.staticTexts["DJ Spooky & Kronos Quartet"].waitForExistence(timeout: 5), "Failed to load track details screen")
        XCTAssertTrue(application.staticTexts["Genre: Soundtrack"].waitForExistence(timeout: 5), "Failed to load track details screen")
        XCTAssertTrue(application.staticTexts["Country: USA"].waitForExistence(timeout: 5), "Failed to load track details screen")
        XCTAssertTrue(application.staticTexts["Release date: August 28, 2015"].waitForExistence(timeout: 5), "Failed to load track details screen")

        XCUIDevice.shared.orientation = .landscapeLeft

        XCTAssertFalse(application.staticTexts["Rebirth of a Nation"].isHittable, "Failed to load track details screen")
        XCTAssertFalse(application.staticTexts["DJ Spooky & Kronos Quartet"].isHittable, "Failed to load track details screen")
        XCTAssertFalse(application.staticTexts["Genre: Soundtrack"].isHittable, "Failed to load track details screen")
        XCTAssertFalse(application.staticTexts["Country: USA"].isHittable, "Failed to load track details screen")
        XCTAssertFalse(application.staticTexts["Release date: August 28, 2015"].isHittable, "Failed to load track details screen")

        XCUIDevice.shared.orientation = .portrait

        XCTAssertTrue(application.buttons.firstMatch.waitForExistence(timeout: 5), "A 'back' button should be available")
        application.buttons.firstMatch.tap()
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Failed to pop to home screen")
    }

    func testNavigationWhenSearchingBySong() {
        mockServer.addMockedResponse(SearchStub.Song.emptyResponse)
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Application did not load to home screen!")
        application.segmentedControls.firstMatch.buttons["Song"].tap()
        XCTAssertTrue(application.segmentedControls.firstMatch.buttons["Song"].isSelected, "'Song' search scope should be selected")

        mockServer.addMockedResponse(SearchStub.Song.ladyMadonna)
        application.searchFields.firstMatch.tap()
        application.searchFields.firstMatch.typeText("Lady Madonna")
        XCTAssertTrue(application.staticTexts["The Beatles"].waitForExistence(timeout: 5), "Failed to load search results")
        application.staticTexts["The Beatles"].tap()
        XCTAssertFalse(application.keyboards.firstMatch.waitForExistence(timeout: 2), "Keyboard was not dismissed when supposed to")

        application.tables.firstMatch.cells.firstMatch.staticTexts["Lady Madonna"].tap()
        XCTAssertTrue(application.otherElements["Video"].waitForExistence(timeout: 5), "Failed to load track details screen")
        XCTAssertTrue(application.staticTexts["Lady Madonna"].waitForExistence(timeout: 5), "Failed to load track details screen")
        XCTAssertTrue(application.staticTexts["The Beatles"].waitForExistence(timeout: 5), "Failed to load track details screen")
        XCTAssertTrue(application.staticTexts["Genre: Rock"].waitForExistence(timeout: 5), "Failed to load track details screen")
        XCTAssertTrue(application.staticTexts["Country: USA"].waitForExistence(timeout: 5), "Failed to load track details screen")
        XCTAssertTrue(application.staticTexts["Release date: March 15, 1968"].waitForExistence(timeout: 5), "Failed to load track details screen")

        XCUIDevice.shared.orientation = .landscapeLeft

        XCTAssertFalse(application.staticTexts["Lady Madonna"].isHittable, "Failed to load track details screen")
        XCTAssertFalse(application.staticTexts["The Beatles"].isHittable, "Failed to load track details screen")
        XCTAssertFalse(application.staticTexts["Genre: Rock"].isHittable, "Failed to load track details screen")
        XCTAssertFalse(application.staticTexts["Country: USA"].isHittable, "Failed to load track details screen")
        XCTAssertFalse(application.staticTexts["Release date: March 15, 1968"].isHittable, "Failed to load track details screen")

        XCUIDevice.shared.orientation = .portrait

        XCTAssertTrue(application.buttons.firstMatch.waitForExistence(timeout: 5), "A 'back' button should be available")
        application.buttons.firstMatch.tap()
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Failed to pop to home screen")
    }
}
