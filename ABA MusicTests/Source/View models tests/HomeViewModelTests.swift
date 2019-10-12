@testable import ABA_Music
import XCTest

class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModelType!

    override func setUp() {
        super.setUp()
        viewModel = HomeViewModel(repository: MockSearchRepository())
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    // MARK: Data source updated by term or scope changes

    func testArtistSearch() {
        let searchTerm = "Search this artist"
        let searchScopeIndex = 0

        let searchScopeExpectation = expectation(description: "dataSourceWasMutated(_:) has been called")
        let delegate = MockDataSourceControllerDelegate()
        delegate.didMutateDataSource = { [weak self] in
            guard let self = self else { return }
            XCTAssertEqual(self.viewModel.dataSource.totalRowCount, 0)
            XCTAssertNil(self.viewModel.delegate)
            XCTAssertEqual(self.viewModel.searchTerm, "")
            XCTAssertEqual(self.viewModel.searchScopeIndex, searchScopeIndex)
            searchScopeExpectation.fulfill()
        }
        viewModel.dataSource.delegate = delegate
        viewModel.updateSearchScope(searchScopeIndex)
        waitForExpectations(timeout: 1.0)

        let searchTermExpectation = expectation(description: "dataSourceWasMutated(_:) has been called")
        delegate.didMutateDataSource = { [weak self] in
            guard let self = self else { return }
            XCTAssertEqual(self.viewModel.dataSource.totalRowCount, 5)
            XCTAssertNil(self.viewModel.delegate)
            XCTAssertEqual(self.viewModel.searchTerm, searchTerm)
            XCTAssertEqual(self.viewModel.searchScopeIndex, searchScopeIndex)
            searchTermExpectation.fulfill()
        }
        viewModel.updateSearchTerm(searchTerm)
        waitForExpectations(timeout: 1.0)
    }

    func testSongSearch() {
        let searchTerm = "Search this song"
        let searchScopeIndex = 1

        let searchScopeExpectation = expectation(description: "dataSourceWasMutated(_:) has been called")
        let delegate = MockDataSourceControllerDelegate()
        delegate.didMutateDataSource = { [weak self] in
            guard let self = self else { return }
            XCTAssertEqual(self.viewModel.dataSource.totalRowCount, 0)
            XCTAssertNil(self.viewModel.delegate)
            XCTAssertEqual(self.viewModel.searchTerm, "")
            XCTAssertEqual(self.viewModel.searchScopeIndex, searchScopeIndex)
            searchScopeExpectation.fulfill()
        }
        viewModel.dataSource.delegate = delegate
        viewModel.updateSearchScope(searchScopeIndex)
        waitForExpectations(timeout: 1.0)

        let searchTermExpectation = expectation(description: "dataSourceWasMutated(_:) has been called")
        delegate.didMutateDataSource = { [weak self] in
            guard let self = self else { return }
            XCTAssertEqual(self.viewModel.dataSource.totalRowCount, 1)
            XCTAssertNil(self.viewModel.delegate)
            XCTAssertEqual(self.viewModel.searchTerm, searchTerm)
            XCTAssertEqual(self.viewModel.searchScopeIndex, searchScopeIndex)
            searchTermExpectation.fulfill()
        }
        viewModel.updateSearchTerm(searchTerm)
        waitForExpectations(timeout: 1.0)
    }

    func testAlbumSearch() {
         let searchTerm = "Search this song"
         let searchScopeIndex = 2

         let searchScopeExpectation = expectation(description: "dataSourceWasMutated(_:) has been called")
         let delegate = MockDataSourceControllerDelegate()
         delegate.didMutateDataSource = { [weak self] in
             guard let self = self else { return }
             XCTAssertEqual(self.viewModel.dataSource.totalRowCount, 0)
             XCTAssertNil(self.viewModel.delegate)
             XCTAssertEqual(self.viewModel.searchTerm, "")
             XCTAssertEqual(self.viewModel.searchScopeIndex, searchScopeIndex)
             searchScopeExpectation.fulfill()
         }
         viewModel.dataSource.delegate = delegate
         viewModel.updateSearchScope(searchScopeIndex)
         waitForExpectations(timeout: 1.0)

         let searchTermExpectation = expectation(description: "dataSourceWasMutated(_:) has been called")
         delegate.didMutateDataSource = { [weak self] in
             guard let self = self else { return }
             XCTAssertEqual(self.viewModel.dataSource.totalRowCount, 3)
             XCTAssertNil(self.viewModel.delegate)
             XCTAssertEqual(self.viewModel.searchTerm, searchTerm)
             XCTAssertEqual(self.viewModel.searchScopeIndex, searchScopeIndex)
             searchTermExpectation.fulfill()
         }
         viewModel.updateSearchTerm(searchTerm)
         waitForExpectations(timeout: 1.0)
     }

    // MARK: Delegate triggered by error

    func testArtistSearchError() {
        let searchTerm = "error"
        let searchScopeIndex = 0

        let searchTermExpectation = expectation(description: "viewModelFailedToFetchData(_:) has been called")
        let delegate = MockHomeViewModelDelegate()
        delegate.didFailToFetchData = { [weak self] in
            guard let self = self else { return }
            XCTAssertEqual(self.viewModel.dataSource.totalRowCount, 0)
            XCTAssertNotNil(self.viewModel.delegate)
            XCTAssertEqual(self.viewModel.searchTerm, searchTerm)
            XCTAssertEqual(self.viewModel.searchScopeIndex, searchScopeIndex)
            searchTermExpectation.fulfill()
        }
        viewModel.delegate = delegate
        viewModel.updateSearchTerm(searchTerm)
        waitForExpectations(timeout: 1.0)
    }

    func testSongSearchError() {
        let searchTerm = "error"
        let searchScopeIndex = 1

        viewModel.updateSearchScope(searchScopeIndex)

        let searchTermExpectation = expectation(description: "viewModelFailedToFetchData(_:) has been called")
        let delegate = MockHomeViewModelDelegate()
        delegate.didFailToFetchData = { [weak self] in
            guard let self = self else { return }
            XCTAssertEqual(self.viewModel.dataSource.totalRowCount, 0)
            XCTAssertNotNil(self.viewModel.delegate)
            XCTAssertEqual(self.viewModel.searchTerm, searchTerm)
            XCTAssertEqual(self.viewModel.searchScopeIndex, searchScopeIndex)
            searchTermExpectation.fulfill()
        }
        viewModel.delegate = delegate
        viewModel.updateSearchTerm(searchTerm)
        waitForExpectations(timeout: 1.0)

    }

    func testAlbumSearchError() {
         let searchTerm = "error"
         let searchScopeIndex = 2

         viewModel.updateSearchScope(searchScopeIndex)

        let searchTermExpectation = expectation(description: "viewModelFailedToFetchData(_:) has been called")
        let delegate = MockHomeViewModelDelegate()
        delegate.didFailToFetchData = { [weak self] in
            guard let self = self else { return }
            XCTAssertEqual(self.viewModel.dataSource.totalRowCount, 0)
            XCTAssertNotNil(self.viewModel.delegate)
            XCTAssertEqual(self.viewModel.searchTerm, searchTerm)
            XCTAssertEqual(self.viewModel.searchScopeIndex, searchScopeIndex)
            searchTermExpectation.fulfill()
        }
        viewModel.delegate = delegate
        viewModel.updateSearchTerm(searchTerm)
        waitForExpectations(timeout: 1.0)
    }
}
