@testable import ABA_Music
import SnapshotTesting
import XCTest

class SearchResultCollectionCellTests: XCTestCase {

    var cell: SearchResultCollectionCell!

    override func setUp() {
        super.setUp()
        cell = Bundle.main.loadNibNamed(SearchResultCollectionCell.nibName, owner: nil, options: [:])?.first as? SearchResultCollectionCell
    }

    override func tearDown() {
        cell = nil
        super.tearDown()
    }

    func testViewLoadsSuccessfully_NonValidModel() {
        let artist = Artist.generateArtist(index: 3)
        let viewModel = SearchResultCollectionViewModel.populate(with: artist)

        cell.configure(with: viewModel)

        assertSnapshot(matching: cell, as: .image)
    }

    func testViewLoadsSuccessfully_ValidModel() {
        let track = Artist.generateArtist(index: 3).tracks.randomElement()!
        let viewModel = SearchResultCollectionViewModel.populate(with: track)

        cell.configure(with: viewModel)

        assertSnapshot(matching: cell, as: .image)
    }
}
