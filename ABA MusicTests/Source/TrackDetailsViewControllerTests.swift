@testable import ABA_Music
import SnapshotTesting
import XCTest

class TrackDetailsViewControllerTests: XCTestCase {
    var viewController: TrackDetailsViewController!

    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Search", bundle: .main)
        viewController = storyboard.instantiateViewController(identifier: "TrackDetailsViewController") as? TrackDetailsViewController
    }

    override func tearDown() {
        viewController = nil
        super.tearDown()
    }

    func testViewLoadsSuccessfully_NoUrls() {
        viewController.viewModel = MockTrackDetailsViewModel.withoutUrls
        _ = viewController.view
        assertSnapshot(matching: viewController, as: .image)
    }

    func testViewLoadsSuccessfully_ArtworkUrl() {
        viewController.viewModel = MockTrackDetailsViewModel.withArtworkUrl
        _ = viewController.view
        assertSnapshot(matching: viewController, as: .image)
    }

    func testViewLoadsSuccessfully_PreviewUrl() {
        viewController.viewModel = MockTrackDetailsViewModel.withPreviewUrl
        _ = viewController.view
        assertSnapshot(matching: viewController, as: .image)
    }

    func testViewLoadsSuccessfully_WithBothUrls() {
        viewController.viewModel = MockTrackDetailsViewModel.withBothUrls
        _ = viewController.view
        assertSnapshot(matching: viewController, as: .image)
    }

    func testViewLoadsSuccessfully_LongStrings() {
        viewController.viewModel = MockTrackDetailsViewModel.withLongStrings
        _ = viewController.view
        assertSnapshot(matching: viewController, as: .image)
    }
}
