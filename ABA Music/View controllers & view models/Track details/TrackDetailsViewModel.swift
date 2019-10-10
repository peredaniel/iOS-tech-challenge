import Foundation

protocol TrackDetailsViewModelType {
    var artistName: String { get }
    var previewUrl: URL? { get }
    var releaseDate: String? { get }
    var trackCountry: String { get }
    var trackGenre: String { get }
    var trackName: String { get }
}

class TrackDetailsViewModel {
    private let track: Track

    init(track: Track) {
        self.track = track
    }
}

extension TrackDetailsViewModel: TrackDetailsViewModelType {
    var artistName: String {
        return track.artist.name
    }

    var previewUrl: URL? {
        return URL(string: track.previewUrl)
    }

    var releaseDate: String? {
        guard let date = DateFormatter(format: "yyyy-MM-dd'T'HH:mm:ssZ").date(from: track.releaseDate) else {
            return nil
        }
        return DateFormatter(format: "MMM dd,yyyy").string(from: date)
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
