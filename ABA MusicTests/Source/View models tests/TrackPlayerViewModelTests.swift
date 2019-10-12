@testable import ABA_Music
import AVFoundation
import XCTest

class TrackPlayerViewModelTests: XCTestCase {
    var viewModel: TrackPlayerViewModelType!

    override func setUp() {
        super.setUp()
        let track = Artist.generateArtist(index: 0).tracks.first!
        viewModel = TrackPlayerViewModel(url: URL(string: track.previewUrl)!)
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testViewModelPublicAPI() {
        let expectedAVPlayerItem = AVPlayerItem(url: URL(string: "https://mock-url.com")!)
        XCTAssertEqual((viewModel.playerItem.asset as! AVURLAsset).url, (expectedAVPlayerItem.asset as! AVURLAsset).url)
    }
}
