import Foundation

protocol TrackCellViewModelDelegate: AnyObject {
    func didPressTrack(_ track: Track)
}

protocol TrackCellViewModelType {
    var artworkUrl: URL? { get }
    var name: String { get }
    func cellTapped()
}

class TrackCellViewModel {
    private let track: Track
    private weak var delegate: TrackCellViewModelDelegate?

    init(track: Track, delegate: TrackCellViewModelDelegate?) {
        self.track = track
        self.delegate = delegate
    }
}

extension TrackCellViewModel: TrackCellViewModelType {
    var artworkUrl: URL? {
        return URL(string: track.artworkUrl100)
    }

    var name: String {
        return track.name
    }

    func cellTapped() {
        delegate?.didPressTrack(track)
    }
}
