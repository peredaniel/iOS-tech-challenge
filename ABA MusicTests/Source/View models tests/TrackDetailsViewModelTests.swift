@testable import ABA_Music
import XCTest

class TrackDetailsViewModelTests: XCTestCase {
    var viewModel: TrackDetailsViewModelType!

    override func setUp() {
        super.setUp()
        let artist = Artist.generateArtist(index: 0)
        viewModel = TrackDetailsViewModel(track: artist.tracks.first!)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testViewModelPublicAPI() {
        let expectedArtistName = "Mock artist number 1"
        let expectedArtworkUrl = URL(string: "https://mock-url.com")
        let expectedPreviewUrl = URL(string: "https://mock-url.com")
        let expectedReleaseDate = "October 15, 2019"
        let expectedTrackCountry = "USA"
        let expectedTrackGenre = "Rock"
        let expectedTrackName = "Mock track number 1"

        XCTAssertEqual(viewModel.artistName, expectedArtistName)
        XCTAssertNotNil(viewModel.artworkUrl)
        XCTAssertEqual(viewModel.artworkUrl, expectedArtworkUrl)
        XCTAssertNotNil(viewModel.previewUrl)
        XCTAssertEqual(viewModel.previewUrl, expectedPreviewUrl)
        XCTAssertEqual(viewModel.releaseDate, expectedReleaseDate)
        XCTAssertEqual(viewModel.trackCountry, expectedTrackCountry)
        XCTAssertEqual(viewModel.trackGenre, expectedTrackGenre)
        XCTAssertEqual(viewModel.trackName, expectedTrackName)
    }
}
