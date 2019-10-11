@testable import ABA_Music
import SnapshotTesting
import XCTest

class HomeViewControllerTests: XCTestCase {
    var viewController: HomeViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Search", bundle: .main)
        viewController = storyboard.instantiateViewController(identifier: "HomeViewController") as? HomeViewController
        viewController.viewModel = HomeViewModel(repository: SearchRepository(service: MockSearchService()))
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }

    // MARK: Search by artists

    func testSearchByAuthorMultipleSections() {
        _ = viewController.view
        viewController.viewModel.updateSearchTerm("Jackson")
        assertSnapshot(matching: viewController, as: .image)
    }

    func testSearchByAuthorSingleSections() {
        _ = viewController.view
        viewController.viewModel.updateSearchTerm("Beatles")
        assertSnapshot(matching: viewController, as: .image)
    }

    func testSearchByAuthorInitialState() {
        _ = viewController.view
        assertSnapshot(matching: viewController, as: .image)
    }
}
