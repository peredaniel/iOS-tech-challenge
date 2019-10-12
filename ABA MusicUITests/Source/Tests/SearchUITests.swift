import XCTest

class SearchUITests: BaseUITestCase {

    func testScrollingVerticallyAndHorizontallyWithMultipleResults() {
        mockServer.addMockedResponse(SearchStub.Artist.jackson)
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Application did not load to home screen!")
        application.searchFields.firstMatch.typeText("Jackson")
        XCTAssertTrue(application.staticTexts["Alan Jackson"].waitForExistence(timeout: 5), "Failed to load search results")
        application.staticTexts["Alan Jackson"].tap()
        XCTAssertFalse(application.keyboards.firstMatch.waitForExistence(timeout: 2), "Keyboard was not dismissed when supposed to")

        XCTAssertTrue(application.tables.firstMatch.cells.firstMatch.staticTexts["Amazing Grace"].exists)
        application.cells.matching(NSPredicate(format: "isSelected == 1")).firstMatch.swipeLeft()
        XCTAssertFalse(application.tables.firstMatch.cells.firstMatch.staticTexts["Amazing Grace"].exists)

        while !application.staticTexts["Wanda Jackson"].isHittable {
            application.tables.firstMatch.swipeUp()
        }
        XCTAssertTrue(application.staticTexts["Wanda Jackson"].isHittable, "The table view cell is supposed to be hittable after scrolling")
    }

    // MARK: Single search and empty response

    func testSearchArtistWithEmptyResponse() {
        mockServer.addMockedResponse(SearchStub.Artist.emptyResponse)
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Application did not load to home screen!")
        application.searchFields.firstMatch.typeText("Jackson")
        XCTAssertTrue(application.staticTexts["emptyResponseLabel"].waitForExistence(timeout: 5), "Empty message failed to display")
    }

    func testSearchAlbumWithEmptyResponse() {
        mockServer.addMockedResponse(SearchStub.Album.emptyResponse)
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Application did not load to home screen!")
        application.segmentedControls.firstMatch.buttons["Album"].tap()
        XCTAssertTrue(application.segmentedControls.firstMatch.buttons["Album"].isSelected, "'Album' search scope should be selected")

        application.searchFields.firstMatch.tap()
        application.searchFields.firstMatch.typeText("Jackson")
        XCTAssertTrue(application.staticTexts["emptyResponseLabel"].waitForExistence(timeout: 5), "Empty message failed to display")
    }

    func testSearchSongWithEmptyResponse() {
        mockServer.addMockedResponse(SearchStub.Song.emptyResponse)
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Application did not load to home screen!")
        application.segmentedControls.firstMatch.buttons["Song"].tap()
        XCTAssertTrue(application.segmentedControls.firstMatch.buttons["Song"].isSelected, "'Song' search scope should be selected")
        application.searchFields.firstMatch.tap()
        application.searchFields.firstMatch.typeText("Jackson")
        XCTAssertTrue(application.staticTexts["emptyResponseLabel"].waitForExistence(timeout: 5), "Empty message failed to display")
    }

    // MARK: Single search and trigger error

    func testSearchArtistWithErrorResponseAndRetry() {
        mockServer.addMockedResponse(SearchStub.Artist.error)
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Application did not load to home screen!")
        application.searchFields.firstMatch.typeText("Jackson")
        XCTAssertTrue(application.alerts.firstMatch.waitForExistence(timeout: 5), "Alert failed to display")
        application.alerts.buttons.firstMatch.tap()
        XCTAssertFalse(application.alerts.firstMatch.waitForExistence(timeout: 1), "Alert failed to dismiss")

        mockServer.addMockedResponse(SearchStub.Artist.jackson)
        application.searchFields.firstMatch.clearText()
        application.searchFields.firstMatch.typeText("Jackson")
        XCTAssertTrue(application.staticTexts["Alan Jackson"].waitForExistence(timeout: 5), "Failed to load search results")
        application.staticTexts["Alan Jackson"].tap()
        XCTAssertFalse(application.keyboards.firstMatch.waitForExistence(timeout: 2), "Keyboard was not dismissed when supposed to")
    }

    func testSearchAlbumWithErrorResponseAndRetry() {
        mockServer.addMockedResponse(SearchStub.Album.emptyResponse)
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Application did not load to home screen!")
        application.segmentedControls.firstMatch.buttons["Album"].tap()
        XCTAssertTrue(application.segmentedControls.firstMatch.buttons["Album"].isSelected, "'Album' search scope should be selected")

        mockServer.addMockedResponse(SearchStub.Album.error)
        application.searchFields.firstMatch.tap()
        application.searchFields.firstMatch.typeText("Jackson")
        XCTAssertTrue(application.alerts.firstMatch.waitForExistence(timeout: 5), "Alert failed to display")
        application.alerts.buttons.firstMatch.tap()
        XCTAssertFalse(application.alerts.firstMatch.waitForExistence(timeout: 1), "Alert failed to dismiss")

        mockServer.addMockedResponse(SearchStub.Album.jackson)
        application.staticTexts["welcomeLabel"].tap()
        application.searchFields.firstMatch.tap()
        application.searchFields.firstMatch.clearText()
        application.searchFields.firstMatch.typeText("Jackson")
        XCTAssertTrue(application.staticTexts["3T"].waitForExistence(timeout: 5), "Failed to load search results")
        XCTAssertFalse(application.staticTexts["APEK & Shanahan"].waitForExistence(timeout: 1), "Loaded wrong results! Check the MockServer stubs!")

        application.staticTexts["3T"].tap()
        XCTAssertFalse(application.keyboards.firstMatch.waitForExistence(timeout: 2), "Keyboard was not dismissed when supposed to")
    }

    func testSearchSongWithErrorResponseAndRetry() {
        mockServer.addMockedResponse(SearchStub.Song.emptyResponse)
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Application did not load to home screen!")
        application.segmentedControls.firstMatch.buttons["Song"].tap()
        XCTAssertTrue(application.segmentedControls.firstMatch.buttons["Song"].isSelected, "'Song' search scope should be selected")

        mockServer.addMockedResponse(SearchStub.Song.error)
        application.searchFields.firstMatch.tap()
        application.searchFields.firstMatch.typeText("Jackson")
        XCTAssertTrue(application.alerts.firstMatch.waitForExistence(timeout: 5), "Alert failed to display")
        application.alerts.buttons.firstMatch.tap()
        XCTAssertFalse(application.alerts.firstMatch.waitForExistence(timeout: 1), "Alert failed to dismiss")

        mockServer.addMockedResponse(SearchStub.Song.jackson)
        application.searchFields.firstMatch.clearText()
        application.searchFields.firstMatch.typeText("Jackson")
        XCTAssertTrue(application.staticTexts["APEK & Shanahan"].waitForExistence(timeout: 5), "Failed to load search results")
        application.staticTexts["3T"].tap()
        XCTAssertFalse(application.keyboards.firstMatch.waitForExistence(timeout: 2), "Keyboard was not dismissed when supposed to")
    }

    // MARK: Single search and dismiss keyboard

    func testSearchArtistAndDismissKeyboard() {
        mockServer.addMockedResponse(SearchStub.Artist.jackson)
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Application did not load to home screen!")
        application.searchFields.firstMatch.typeText("Jackson")
        XCTAssertTrue(application.staticTexts["Alan Jackson"].waitForExistence(timeout: 5), "Failed to load search results")
        application.staticTexts["Alan Jackson"].tap()
        XCTAssertFalse(application.keyboards.firstMatch.waitForExistence(timeout: 2), "Keyboard was not dismissed when supposed to")
    }

    func testSearchAlbumAndDismissKeyboard() {
        mockServer.addMockedResponse(SearchStub.Album.emptyResponse)
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Application did not load to home screen!")
        application.segmentedControls.firstMatch.buttons["Album"].tap()
        XCTAssertTrue(application.segmentedControls.firstMatch.buttons["Album"].isSelected, "'Album' search scope should be selected")

        mockServer.addMockedResponse(SearchStub.Album.jackson)
        application.searchFields.firstMatch.tap()
        application.searchFields.firstMatch.typeText("Jackson")
        XCTAssertTrue(application.staticTexts["3T"].waitForExistence(timeout: 5), "Failed to load search results")
        XCTAssertFalse(application.staticTexts["APEK & Shanahan"].waitForExistence(timeout: 1), "Loaded wrong results! Check the MockServer stubs!")

        application.staticTexts["3T"].tap()
        XCTAssertFalse(application.keyboards.firstMatch.waitForExistence(timeout: 2), "Keyboard was not dismissed when supposed to")
    }

    func testSearchSongAndDismissKeyboard() {
        mockServer.addMockedResponse(SearchStub.Song.emptyResponse)
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Application did not load to home screen!")
        application.segmentedControls.firstMatch.buttons["Song"].tap()
        XCTAssertTrue(application.segmentedControls.firstMatch.buttons["Song"].isSelected, "'Song' search scope should be selected")

        mockServer.addMockedResponse(SearchStub.Song.jackson)
        application.searchFields.firstMatch.tap()
        application.searchFields.firstMatch.typeText("Jackson")
        XCTAssertTrue(application.staticTexts["APEK & Shanahan"].waitForExistence(timeout: 5), "Failed to load search results")
        application.staticTexts["3T"].tap()
        XCTAssertFalse(application.keyboards.firstMatch.waitForExistence(timeout: 2), "Keyboard was not dismissed when supposed to")
    }

    // MARK: Multiple searches

    func testSearchMultipleArtistsAndDimissKeyboard() {
        mockServer.addMockedResponse(SearchStub.Artist.beatles)
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Application did not load to home screen!")
        application.searchFields.firstMatch.typeText("Beatles")
        XCTAssertTrue(application.staticTexts["The Beatles"].waitForExistence(timeout: 5), "Failed to load search results")

        mockServer.addMockedResponse(SearchStub.Artist.emptyResponse)
        application.searchFields.firstMatch.tap()
        application.searchFields.firstMatch.clearText()
        XCTAssertFalse(application.staticTexts["The Beatles"].waitForExistence(timeout: 2), "Results should disappear when clearing search field")

        mockServer.addMockedResponse(SearchStub.Artist.jackson)
        application.searchFields.firstMatch.typeText("Jackson")
        XCTAssertTrue(application.staticTexts["Alan Jackson"].waitForExistence(timeout: 5), "Failed to load search results")
        application.staticTexts["Alan Jackson"].tap()
        XCTAssertFalse(application.keyboards.firstMatch.waitForExistence(timeout: 2), "Keyboard was not dismissed when supposed to")
    }

    func testSearchMultipleAlbumsAndDismissKeyboard() {
        mockServer.addMockedResponse(SearchStub.Album.emptyResponse)
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Application did not load to home screen!")
        application.segmentedControls.firstMatch.buttons["Album"].tap()
        XCTAssertTrue(application.segmentedControls.firstMatch.buttons["Album"].isSelected, "'Album' search scope should be selected")

        mockServer.addMockedResponse(SearchStub.Album.jackson)
        application.searchFields.firstMatch.tap()
        application.searchFields.firstMatch.typeText("Jackson")
        XCTAssertTrue(application.staticTexts["3T"].waitForExistence(timeout: 5), "Failed to load search results")
        XCTAssertFalse(application.staticTexts["APEK & Shanahan"].waitForExistence(timeout: 1), "Loaded wrong results! Check the MockServer stubs!")

        mockServer.addMockedResponse(SearchStub.Album.emptyResponse)
        application.searchFields.firstMatch.tap()
        application.searchFields.firstMatch.clearText()
        XCTAssertFalse(application.staticTexts["3T"].waitForExistence(timeout: 2), "Results should disappear when clearing search field")

        mockServer.addMockedResponse(SearchStub.Album.rebirth)
        application.searchFields.firstMatch.typeText("Rebirth")
        XCTAssertTrue(application.staticTexts["DJ Spooky & Kronos Quartet"].waitForExistence(timeout: 5), "Failed to load search results")
        application.staticTexts["DJ Spooky & Kronos Quartet"].tap()
        XCTAssertFalse(application.keyboards.firstMatch.waitForExistence(timeout: 2), "Keyboard was not dismissed when supposed to")
    }

    func testSearchMultipleSongsAndDismissKeyboard() {
        mockServer.addMockedResponse(SearchStub.Song.emptyResponse)
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Application did not load to home screen!")
        application.segmentedControls.firstMatch.buttons["Song"].tap()
        XCTAssertTrue(application.segmentedControls.firstMatch.buttons["Song"].isSelected, "'Song' search scope should be selected")

        mockServer.addMockedResponse(SearchStub.Song.ladyMadonna)
        application.searchFields.firstMatch.tap()
        application.searchFields.firstMatch.typeText("Lady Madonna")
        XCTAssertTrue(application.staticTexts["The Beatles"].waitForExistence(timeout: 5), "Failed to load search results")

        mockServer.addMockedResponse(SearchStub.Song.emptyResponse)
        application.searchFields.firstMatch.tap()
        application.searchFields.firstMatch.clearText()
        XCTAssertFalse(application.staticTexts["Lady Madonna"].waitForExistence(timeout: 2), "Results should disappear when clearing search field")

        mockServer.addMockedResponse(SearchStub.Song.jackson)
        application.searchFields.firstMatch.typeText("Jackson")
        XCTAssertTrue(application.staticTexts["APEK & Shanahan"].waitForExistence(timeout: 5), "Failed to load search results")
        application.staticTexts["3T"].tap()
        XCTAssertFalse(application.keyboards.firstMatch.waitForExistence(timeout: 2), "Keyboard was not dismissed when supposed to")
    }

    // MARK: Change scope after search

    func testSearchArtistAndChangeScopeToSong() {
        mockServer.addMockedResponse(SearchStub.Artist.jackson)
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Application did not load to home screen!")
        application.searchFields.firstMatch.typeText("Jackson")
        XCTAssertTrue(application.staticTexts["Alan Jackson"].waitForExistence(timeout: 5), "Failed to load search results")

        mockServer.addMockedResponse(SearchStub.Song.jackson)
        application.segmentedControls.firstMatch.buttons["Song"].tap()
        XCTAssertTrue(application.segmentedControls.firstMatch.buttons["Song"].isSelected, "'Song' search scope should be selected")
        XCTAssertTrue(application.staticTexts["APEK & Shanahan"].waitForExistence(timeout: 5), "Failed to load search results")
        application.staticTexts["3T"].tap()
        XCTAssertFalse(application.keyboards.firstMatch.waitForExistence(timeout: 2), "Keyboard was not dismissed when supposed to")
    }

    func testSearchArtistAndChangeScopeToAlbum() {
        mockServer.addMockedResponse(SearchStub.Artist.jackson)
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Application did not load to home screen!")
        application.searchFields.firstMatch.typeText("Jackson")
        XCTAssertTrue(application.staticTexts["Alan Jackson"].waitForExistence(timeout: 5), "Failed to load search results")

        mockServer.addMockedResponse(SearchStub.Album.jackson)
        application.segmentedControls.firstMatch.buttons["Album"].tap()
        XCTAssertTrue(application.segmentedControls.firstMatch.buttons["Album"].isSelected, "'Album' search scope should be selected")
        XCTAssertTrue(application.staticTexts["3T"].waitForExistence(timeout: 5), "Failed to load search results")
        XCTAssertFalse(application.staticTexts["APEK & Shanahan"].waitForExistence(timeout: 1), "Loaded wrong results! Check the MockServer stubs!")
        application.staticTexts["3T"].tap()
        XCTAssertFalse(application.keyboards.firstMatch.waitForExistence(timeout: 2), "Keyboard was not dismissed when supposed to")
    }

    func testSearchAlbumAndChangeScopeToSong() {
        mockServer.addMockedResponse(SearchStub.Album.emptyResponse)
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Application did not load to home screen!")
        application.segmentedControls.firstMatch.buttons["Album"].tap()
        XCTAssertTrue(application.segmentedControls.firstMatch.buttons["Album"].isSelected, "'Album' search scope should be selected")

        mockServer.addMockedResponse(SearchStub.Album.jackson)
        application.searchFields.firstMatch.tap()
        application.searchFields.firstMatch.typeText("Jackson")
        XCTAssertTrue(application.staticTexts["3T"].waitForExistence(timeout: 5), "Failed to load search results")
        XCTAssertFalse(application.staticTexts["APEK & Shanahan"].waitForExistence(timeout: 1), "Loaded wrong results! Check the MockServer stubs!")

        mockServer.addMockedResponse(SearchStub.Song.jackson)
        application.segmentedControls.firstMatch.buttons["Song"].tap()
        XCTAssertTrue(application.segmentedControls.firstMatch.buttons["Song"].isSelected, "'Song' search scope should be selected")
        XCTAssertTrue(application.staticTexts["APEK & Shanahan"].waitForExistence(timeout: 5), "Failed to load search results")
        application.staticTexts["3T"].tap()
        XCTAssertFalse(application.keyboards.firstMatch.waitForExistence(timeout: 2), "Keyboard was not dismissed when supposed to")
    }

    func testSearchAlbumAndChangeScopeToArtist() {
        mockServer.addMockedResponse(SearchStub.Album.emptyResponse)
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Application did not load to home screen!")
        application.segmentedControls.firstMatch.buttons["Album"].tap()
        XCTAssertTrue(application.segmentedControls.firstMatch.buttons["Album"].isSelected, "'Album' search scope should be selected")

        mockServer.addMockedResponse(SearchStub.Album.jackson)
        application.searchFields.firstMatch.tap()
        application.searchFields.firstMatch.typeText("Jackson")
        XCTAssertTrue(application.staticTexts["3T"].waitForExistence(timeout: 5), "Failed to load search results")
        XCTAssertFalse(application.staticTexts["APEK & Shanahan"].waitForExistence(timeout: 1), "Loaded wrong results! Check the MockServer stubs!")

        mockServer.addMockedResponse(SearchStub.Artist.jackson)
        application.segmentedControls.firstMatch.buttons["Artist"].tap()
        XCTAssertTrue(application.segmentedControls.firstMatch.buttons["Artist"].isSelected, "'Artist' search scope should be selected")
        XCTAssertTrue(application.staticTexts["Alan Jackson"].waitForExistence(timeout: 5), "Failed to load search results")
        application.staticTexts["Alan Jackson"].tap()
        XCTAssertFalse(application.keyboards.firstMatch.waitForExistence(timeout: 2), "Keyboard was not dismissed when supposed to")
    }

    func testSearchSongAndChangeScopeToArtist() {
        mockServer.addMockedResponse(SearchStub.Song.emptyResponse)
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Application did not load to home screen!")
        application.segmentedControls.firstMatch.buttons["Song"].tap()
        XCTAssertTrue(application.segmentedControls.firstMatch.buttons["Song"].isSelected, "'Song' search scope should be selected")

        mockServer.addMockedResponse(SearchStub.Song.jackson)
        application.searchFields.firstMatch.tap()
        application.searchFields.firstMatch.typeText("Jackson")
        XCTAssertTrue(application.staticTexts["APEK & Shanahan"].waitForExistence(timeout: 5), "Failed to load search results")

        mockServer.addMockedResponse(SearchStub.Artist.jackson)
        application.segmentedControls.firstMatch.buttons["Artist"].tap()
        XCTAssertTrue(application.segmentedControls.firstMatch.buttons["Artist"].isSelected, "'Artist' search scope should be selected")
        XCTAssertTrue(application.staticTexts["Alan Jackson"].waitForExistence(timeout: 5), "Failed to load search results")
        application.staticTexts["Alan Jackson"].tap()
        XCTAssertFalse(application.keyboards.firstMatch.waitForExistence(timeout: 2), "Keyboard was not dismissed when supposed to")
    }

    func testSearchSongAndChangeScopeToAlbum() {
        mockServer.addMockedResponse(SearchStub.Album.emptyResponse)
        XCTAssertTrue(application.searchFields["Type in to search..."].waitForExistence(timeout: 5), "Application did not load to home screen!")
        application.segmentedControls.firstMatch.buttons["Song"].tap()
        XCTAssertTrue(application.segmentedControls.firstMatch.buttons["Song"].isSelected, "'Song' search scope should be selected")

        mockServer.addMockedResponse(SearchStub.Song.jackson)
        application.searchFields.firstMatch.tap()
        application.searchFields.firstMatch.typeText("Jackson")
        XCTAssertTrue(application.staticTexts["APEK & Shanahan"].waitForExistence(timeout: 5), "Loaded wrong results! Check the MockServer stubs!")

        mockServer.addMockedResponse(SearchStub.Album.jackson)
        application.segmentedControls.firstMatch.buttons["Album"].tap()
        XCTAssertTrue(application.segmentedControls.firstMatch.buttons["Album"].isSelected, "'Album' search scope should be selected")
        XCTAssertTrue(application.staticTexts["3T"].waitForExistence(timeout: 5), "Failed to load search results")
        XCTAssertFalse(application.staticTexts["APEK & Shanahan"].waitForExistence(timeout: 1), "Loaded wrong results! Check the MockServer stubs!")
        application.staticTexts["3T"].tap()
        XCTAssertFalse(application.keyboards.firstMatch.waitForExistence(timeout: 2), "Keyboard was not dismissed when supposed to")
    }
}
