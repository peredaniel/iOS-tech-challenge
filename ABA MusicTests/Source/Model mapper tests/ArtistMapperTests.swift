@testable import ABA_Music
import XCTest

class ArtistMapperTests: XCTestCase {
    func testMapperToArtistIsCorrect() {
        let result = loadMockFromBundle()?.results.first
        let artist = Artist(searchResult: result!)

        XCTAssertEqual(artist.name, "The Beatles")
        XCTAssertEqual(artist.identifier, 136975)
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
