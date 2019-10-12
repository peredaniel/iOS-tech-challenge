@testable import ABA_Music
import SnapshotTesting
import XCTest

class SearchResultTableCellTests: XCTestCase {

    var cell: SearchResultTableCell!

    override func setUp() {
        super.setUp()
        cell = Bundle.main.loadNibNamed(SearchResultTableCell.nibName, owner: nil, options: [:])?.first as? SearchResultTableCell
        cell.backgroundColor = .white
    }

    override func tearDown() {
        cell = nil
        super.tearDown()
    }

    func testViewLoadsSuccessfully_NoTracks() {
        let artist = Artist.generateArtist(index: 3)
        artist.tracks.removeAll()
        let viewModel = SearchResultTableViewModel(artist: artist, delegate: nil)

        cell.configure(with: viewModel)

        assertSnapshot(matching: cell, as: .image)
    }

    func testViewLoadsSuccessfully_SingleTrack() {
        let artist = Artist.generateArtist(index: 0)
        let viewModel = SearchResultTableViewModel(artist: artist, delegate: nil)

        cell.configure(with: viewModel)

        assertSnapshot(matching: cell, as: .image)
    }

    func testViewLoadsSuccessfully_MultipleTracks() {
        let artist = Artist.generateArtist(index: 5)
        let viewModel = SearchResultTableViewModel(artist: artist, delegate: nil)

        cell.configure(with: viewModel)

        assertSnapshot(matching: cell, as: .image)
    }
}
