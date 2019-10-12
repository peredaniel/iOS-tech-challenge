@testable import ABA_Music

class MockSearchResultTableDelegate: SearchResultTableDelegate {
    var didSelectTrack: ((Track) -> Void)?

    func didSelectTrack(_ track: Track) {
        didSelectTrack?(track)
    }
}
