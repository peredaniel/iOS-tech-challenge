import Foundation

protocol ArtistCellViewModelDelegate: AnyObject {
    func didPressTrack(_ track: Track)
}

protocol ArtistCellViewModelType {
    var name: String { get }
    var tracksCount: Int { get }

    func viewModel(forObjectAt indexPath: IndexPath) -> TrackCellViewModelType?
}

class ArtistCellViewModel {
    private let artist: Artist
    private weak var delegate: ArtistCellViewModelDelegate?

    init(artist: Artist, delegate: ArtistCellViewModelDelegate?) {
        self.artist = artist
        self.delegate = delegate
    }
}

extension ArtistCellViewModel: ArtistCellViewModelType {
    var name: String {
        return artist.name
    }

    var tracksCount: Int {
        return artist.tracks.count
    }

    func viewModel(forObjectAt indexPath: IndexPath) -> TrackCellViewModelType? {
        guard indexPath.row < tracksCount else {
            return nil
        }
        return TrackCellViewModel(track: artist.tracks[indexPath.row], delegate: self)
    }
}

extension ArtistCellViewModel: TrackCellViewModelDelegate {
    func didPressTrack(_ track: Track) {
        delegate?.didPressTrack(track)
    }
}
