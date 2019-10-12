@testable import ABA_Music
import XCTest

class SearchResultCollectionViewModelTests: XCTestCase {
    func testViewModelPublicAPI() {
        let track = Artist.generateArtist(index: 0).tracks.first!
        let viewModel = SearchResultCollectionViewModel(track: track) as SearchResultCollectionViewModelType

        let expectedArtworkUrl = URL(string: "https://mock-url.com")
        let expectedName = "Mock track number 1"
        let expectedReleaseDate = "Oct 15, 2019"

        XCTAssertNotNil(viewModel.artworkUrl)
        XCTAssertEqual(viewModel.artworkUrl, expectedArtworkUrl)
        XCTAssertEqual(viewModel.name, expectedName)
        XCTAssertEqual(viewModel.releaseDate, expectedReleaseDate)
    }

    func testCellDataControllerConformanceWithValidModel() {
        let track = Artist.generateArtist(index: 0).tracks.first!
        let viewModel = SearchResultCollectionViewModel.populate(with: track) as? SearchResultCollectionViewModelType

        let expectedArtworkUrl = URL(string: "https://mock-url.com")
        let expectedName = "Mock track number 1"
        let expectedReleaseDate = "Oct 15, 2019"

        XCTAssertNotNil(viewModel)
        XCTAssertNotNil(viewModel?.artworkUrl)
        XCTAssertEqual(viewModel?.artworkUrl, expectedArtworkUrl)
        XCTAssertEqual(viewModel?.name, expectedName)
        XCTAssertEqual(viewModel?.releaseDate, expectedReleaseDate)
    }

    func testCellDataControllerConformanceWithNonValidModel() {
        let model: Int = 0
        let viewModel = SearchResultCollectionViewModel.populate(with: model) as? SearchResultCollectionViewModelType

        let expectedName = ""
        let expectedReleaseDate = "Jan 01, 1970"

        XCTAssertNotNil(viewModel)
        XCTAssertNil(viewModel?.artworkUrl)
        XCTAssertEqual(viewModel?.name, expectedName)
        XCTAssertEqual(viewModel?.releaseDate, expectedReleaseDate)
    }
}
