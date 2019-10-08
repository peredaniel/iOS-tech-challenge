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
    private lazy var inputDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }()

    private lazy var outputDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy"
        return dateFormatter
    }()

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
        guard let date = inputDateFormatter.date(from: track.releaseDate) else {
            return nil
        }
        return outputDateFormatter.string(from: date)
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
