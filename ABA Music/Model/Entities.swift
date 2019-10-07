import Foundation

class Track: Equatable {
    var trackId: Int
    var artist: Artist
    var artistName: String
    var trackName: String
    var previewUrl: String
    var artworkUrl100: String
    var primaryGenreName: String
    var country: String
    var releaseDate: String

    init(
        trackId: Int,
        artist: Artist,
        artistName: String,
        trackName: String,
        previewUrl: String,
        artworkUrl100: String,
        primaryGenreName: String,
        country: String,
        releaseDate: String
    ) {
        self.trackId = trackId
        self.artist = artist
        self.artistName = artistName
        self.trackName = trackName
        self.previewUrl = previewUrl
        self.artworkUrl100 = artworkUrl100
        self.primaryGenreName = primaryGenreName
        self.country = country
        self.releaseDate = releaseDate
    }

    static func == (lhs: Track, rhs: Track) -> Bool {
        return lhs.trackId == rhs.trackId
    }
}

class Artist: Equatable {
    var artistId: Int
    var artistName: String
    var tracks: [Track]

    init(
        artistId: Int,
        artistName: String,
        tracks: [Track]
    ) {
        self.artistId = artistId
        self.artistName = artistName
        self.tracks = tracks
    }

    static func == (lhs: Artist, rhs: Artist) -> Bool {
        return lhs.artistId == rhs.artistId
    }
}
