import Foundation

extension Track {
    convenience init(searchResult: SearchResponse.Result) {
        self.init(
            identifier: searchResult.trackId,
            artist: Artist(searchResult: searchResult),
            name: searchResult.trackName,
            previewUrl: searchResult.previewUrl ?? "",
            artworkUrl100: searchResult.artworkUrl100,
            primaryGenreName: searchResult.primaryGenreName,
            country: searchResult.country,
            releaseDate: DateFormatter(format: SearchResponse.Constant.dateFormat).date(from: searchResult.releaseDate)?.timeIntervalSince1970 ?? 0.0
        )
    }
}
