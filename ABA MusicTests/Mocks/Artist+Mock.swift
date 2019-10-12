@testable import ABA_Music
import Foundation

extension Artist {
    static func generateArtist(index: Int) -> Artist {
        let artist = Artist(
            identifier: index,
            name: "Mock artist number \(index + 1)",
            tracks: []
        )
        artist.tracks = (0...index).map { Track.generateMock(artist: artist, index: $0) }
        return artist
    }
}
