@testable import ABA_Music
import DataSourceController
import XCTest

class SearchResultTableViewModelTests: XCTestCase {
    func testViewModelPublicAPI() {
        let artist = Artist.generateArtist(index: 5)
        let delegate = MockSearchResultTableDelegate()
        let viewModel = SearchResultTableViewModel(artist: artist, delegate: delegate) as SearchResultTableViewModelType
        let indexOfTrackToSelect = (0..<artist.tracks.count).randomElement()!

        let expectedRows = Array(artist.tracks.sorted().reversed())
        let expectedName = "Mock artist number 6"

        XCTAssertEqual(viewModel.name, expectedName)
        XCTAssertEqual(viewModel.dataSource.totalRowCount, artist.tracks.count)
        XCTAssertNotNil((0..<artist.tracks.count).compactMap { viewModel.dataSource.modelObject(at: IndexPath(row: $0, section: 0)) } as? [Track])
        XCTAssertEqual((0..<artist.tracks.count).compactMap { viewModel.dataSource.modelObject(at: IndexPath(row: $0, section: 0)) } as? [Track], expectedRows)

        let selectTrackExpectation = expectation(description: "didSelectTrack(_:) has been called")
        delegate.didSelectTrack = { track in
            XCTAssertEqual(track, expectedRows[indexOfTrackToSelect])
            selectTrackExpectation.fulfill()
        }

        viewModel.didSelectItem(at: IndexPath(row: indexOfTrackToSelect, section: 0))
        waitForExpectations(timeout: 1.0)
    }

    func testCellDataControllerConformanceWithValidModel() {
        let artist = Artist.generateArtist(index: 5)
        let delegate = MockSearchResultTableDelegate()
        let viewModel = SearchResultTableViewModel.populate(with: SearchResultTableCellData(artist: artist, delegate: delegate)) as? SearchResultTableViewModelType
        let indexOfTrackToSelect = (0..<artist.tracks.count).randomElement()!

        let expectedRows = Array(artist.tracks.sorted().reversed())
        let expectedName = "Mock artist number 6"

        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel?.name, expectedName)
        XCTAssertEqual(viewModel?.dataSource.totalRowCount, artist.tracks.count)
        XCTAssertNotNil((0..<artist.tracks.count).compactMap { viewModel?.dataSource.modelObject(at: IndexPath(row: $0, section: 0)) } as? [Track])
        XCTAssertEqual((0..<artist.tracks.count).compactMap { viewModel?.dataSource.modelObject(at: IndexPath(row: $0, section: 0)) } as? [Track], expectedRows)

        let selectTrackExpectation = expectation(description: "didSelectTrack(_:) has been called")
        delegate.didSelectTrack = { track in
            XCTAssertEqual(track, expectedRows[indexOfTrackToSelect])
            selectTrackExpectation.fulfill()
        }

        viewModel?.didSelectItem(at: IndexPath(row: indexOfTrackToSelect, section: 0))
        waitForExpectations(timeout: 1.0)
    }

    func testCellDataControllerConformanceWithNonValidModel() {
        let model = Artist.generateArtist(index: 5)
        let viewModel = SearchResultTableViewModel.populate(with: model) as? SearchResultTableViewModelType

        let expectedName = ""

        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel?.name, expectedName)
        XCTAssertEqual(viewModel?.dataSource.totalRowCount, 0)
    }
}
