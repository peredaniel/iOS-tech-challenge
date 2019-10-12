@testable import ABA_Music
import XCTest

class TrackMapperTests: XCTestCase {
    func testMapperToTrackIsCorrect() {
        let result = loadMockFromBundle()?.results.first
        let track = Track(searchResult: result!)
        let expectedArtist = Artist(identifier: 136975, name: "The Beatles", tracks: [])

        XCTAssertEqual(track.identifier, 1358426502)
        XCTAssertEqual(track.artist, expectedArtist)
        XCTAssertEqual(track.name, "Lady Madonna")
        XCTAssertEqual(track.previewUrl, "https://video-ssl.itunes.apple.com/itunes-assets/Video118/v4/0e/05/be/0e05beee-f48c-852d-3c6d-770b24590fa0/mzvf_6324317284605897663.640x480.h264lc.U.p.m4v")
        XCTAssertEqual(track.artworkUrl100, "https://is4-ssl.mzstatic.com/image/thumb/Video128/v4/0e/27/41/0e2741c1-a69d-81af-b337-021977875327/source/100x100bb.jpg")
        XCTAssertEqual(track.primaryGenreName, "Rock")
        XCTAssertEqual(track.country, "USA")
        XCTAssertEqual(track.releaseDate, -56736000.0)

    }

    private func loadMockFromBundle() -> SearchResponse? {
        guard let url = Bundle(for: MockSearchService.self).url(forResource: "Lady Madonna_songTerm", withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let response = try? JSONDecoder().decode(SearchResponse.self, from: data) else {
            print("Could not read JSON file!")
            return nil
        }
        return response
    }
}
