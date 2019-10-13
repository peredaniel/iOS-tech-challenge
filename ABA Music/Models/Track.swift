class Track: Equatable, Comparable {
    var identifier: Int
    var artist: Artist
    var name: String
    var previewUrl: String
    var artworkUrl100: String
    var primaryGenreName: String
    var country: String
    var releaseDate: Double

    init(
        identifier: Int,
        artist: Artist,
        name: String,
        previewUrl: String,
        artworkUrl100: String,
        primaryGenreName: String,
        country: String,
        releaseDate: Double
    ) {
        self.identifier = identifier
        self.artist = artist
        self.name = name
        self.previewUrl = previewUrl
        self.artworkUrl100 = artworkUrl100
        self.primaryGenreName = primaryGenreName
        self.country = country
        self.releaseDate = releaseDate
    }

    static func == (lhs: Track, rhs: Track) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    static func < (lhs: Track, rhs: Track) -> Bool {
        return lhs.releaseDate < rhs.releaseDate
    }
}

extension Track {
    static var fallback: Track {
        return Track(
            identifier: 0,
            artist: .fallback,
            name: "",
            previewUrl: "",
            artworkUrl100: "",
            primaryGenreName: "",
            country: "",
            releaseDate: 0
        )
    }
}
