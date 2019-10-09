class Artist: Equatable, Comparable {
    var identifier: Int
    var name: String
    var tracks: [Track]

    init(
        identifier: Int,
        name: String,
        tracks: [Track]
    ) {
        self.identifier = identifier
        self.name = name
        self.tracks = tracks
    }

    static func == (lhs: Artist, rhs: Artist) -> Bool {
        return lhs.identifier == rhs.identifier
    }

    static func < (lhs: Artist, rhs: Artist) -> Bool {
        return lhs.name.compare(rhs.name) == .orderedAscending
    }
}

extension Artist {
    static var fallback: Artist {
        return Artist(identifier: 0, name: "", tracks: [])
    }
}
