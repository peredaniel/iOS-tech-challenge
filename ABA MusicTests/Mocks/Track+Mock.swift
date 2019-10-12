@testable import ABA_Music
import Foundation

extension Track {
    static func generateMock(artist: Artist, index: Int) -> Track {
        return Track(
            identifier: index,
            artist: artist,
            name: "Mock track number \(index + 1)",
            previewUrl: "https://mock-url.com",
            artworkUrl100: "https://mock-url.com",
            primaryGenreName: "Rock",
            country: "USA",
            releaseDate: 1571122800
        )
    }
}
