import Foundation

protocol TrackDetailsViewModelType {
    var artistName: String { get }
    var artworkUrl: URL? { get }
    var previewUrl: URL? { get }
    var releaseDate: String? { get }
    var trackCountry: String { get }
    var trackGenre: String { get }
    var trackName: String { get }
}

class TrackDetailsViewModel {
    private enum Constant {
        static let dateFormat = "MMMM dd, yyyy"
    }

    private let track: Track

    init(track: Track) {
        self.track = track
    }
}

extension TrackDetailsViewModel: TrackDetailsViewModelType {
    var artistName: String {
        return track.artist.name
    }

    var artworkUrl: URL? {
        return URL(string: track.artworkUrl100)
    }

    var previewUrl: URL? {
        return URL(string: track.previewUrl)
    }

    var releaseDate: String? {
        return DateFormatter(format: Constant.dateFormat).string(from: Date(timeIntervalSince1970: track.releaseDate))
    }

    var trackCountry: String {
        return track.country
    }

    var trackGenre: String {
        return track.primaryGenreName
    }

    var trackName: String {
        return track.name
    }
}
