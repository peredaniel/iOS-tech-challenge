@testable import ABA_Music
import XCTest

class SearchRepositoryTests: XCTestCase {
    var repository: SearchRepository!

    override func setUp() {
        super.setUp()
        repository = SearchRepository(service: MockSearchService())
    }

    override func tearDown() {
        repository = nil
        super.tearDown()
    }

    // MARK: Search by artist

    func testEmptyArtistStringReturnsEmptyResponse() {
        let term = ""

        repository.searchMusicVideos(artist: term) { result in
            switch result {
            case .success(let artists):
                XCTAssertEqual(artists.count, 0)
            case .failure:
                // The result should not be an error! If so, fail the test and fix it.
                XCTAssertTrue(false)
            }
        }
    }

    func testValidArtistStringReturnsResponse_SingleArtist() {
        let term = "Beatles"

        repository.searchMusicVideos(artist: term) { result in
            switch result {
            case .success(let artists):
                XCTAssertEqual(artists.count, 1)
                XCTAssertEqual(artists.map { $0.name.lowercased() }.filter { $0.contains(term.lowercased()) }.count, artists.count)
                XCTAssertEqual(artists.flatMap { $0.tracks }.count, 24)
            case .failure:
                // The result should not be an error! If so, fail the test and fix it.
                XCTAssertTrue(false)
            }
        }
    }

    func testValidArtistStringReturnsResponse_MultipleArtists() {
        let term = "Jackson"

        repository.searchMusicVideos(artist: term) { result in
            switch result {
            case .success(let artists):
                XCTAssertEqual(artists.count, 10)
                XCTAssertEqual(artists.map { $0.name.lowercased() }.filter { $0.contains(term.lowercased()) }.count, artists.count)
                XCTAssertEqual(artists.flatMap { $0.tracks }.count, 110)
            case .failure:
                // The result should not be an error! If so, fail the test and fix it.
                XCTAssertTrue(false)
            }
        }
    }

    func testInvalidArtistStringReturnsError() {
        let term = "Some non valid string"
        repository.searchMusicVideos(artist: term) { result in
            switch result {
            case .success:
                // The result should not be a succes! If so, fail the test and fix it.
                XCTAssertTrue(false)
            case .failure(let error):
                XCTAssertEqual(error as? SearchError, SearchError.parsingError)
            }
        }
    }

    // MARK: Search by album

    func testEmptyAlbumStringReturnsEmptyResponse() {
        let term = ""

        repository.searchMusicVideos(album: term) { result in
            switch result {
            case .success(let artists):
                XCTAssertEqual(artists.count, 0)
            case .failure:
                // The result should not be an error! If so, fail the test and fix it.
                XCTAssertTrue(false)
            }
        }
    }

    func testValidAlbumStringReturnsResponse_SingleArtist() {
        let term = "Rebirth"

        repository.searchMusicVideos(album: term) { result in
            switch result {
            case .success(let artists):
                XCTAssertEqual(artists.count, 1)
                XCTAssertEqual(artists.flatMap { $0.tracks }.count, 1)
            case .failure:
                // The result should not be an error! If so, fail the test and fix it.
                XCTAssertTrue(false)
            }
        }
    }

    func testValidAlbumStringReturnsResponse_MultipleArtists() {
        let term = "Jackson"

        repository.searchMusicVideos(album: term) { result in
            switch result {
            case .success(let artists):
                XCTAssertEqual(artists.count, 4)
                XCTAssertEqual(artists.flatMap { $0.tracks }.count, 44)
            case .failure:
                // The result should not be an error! If so, fail the test and fix it.
                XCTAssertTrue(false)
            }
        }
    }

    func testInvalidAlbumStringReturnsError() {
        let term = "Some non valid string"
        repository.searchMusicVideos(album: term) { result in
            switch result {
            case .success:
                // The result should not be a succes! If so, fail the test and fix it.
                XCTAssertTrue(false)
            case .failure(let error):
                XCTAssertEqual(error as? SearchError, SearchError.parsingError)
            }
        }
    }

    // MARK: Search by song

    func testEmptySongStringReturnsEmptyResponse() {
        let term = ""

        repository.searchMusicVideos(song: term) { result in
            switch result {
            case .success(let artists):
                XCTAssertEqual(artists.count, 0)
            case .failure:
                // The result should not be an error! If so, fail the test and fix it.
                XCTAssertTrue(false)
            }
        }
    }

    func testValidSongStringReturnsResponse_SingleArtist() {
        let term = "Lady Madonna"

        repository.searchMusicVideos(song: term) { result in
            switch result {
            case .success(let artists):
                let tracks = artists.flatMap { $0.tracks }
                XCTAssertEqual(artists.count, 1)
                XCTAssertEqual(tracks.map { $0.name }.filter { $0.contains(term) }.count, tracks.count)
                XCTAssertEqual(tracks.count, 1)
            case .failure:
                // The result should not be an error! If so, fail the test and fix it.
                XCTAssertTrue(false)
            }
        }
    }

    func testValidSongStringReturnsResponse_MultipleArtists() {
        let term = "Jackson"

        repository.searchMusicVideos(song: term) { result in
            switch result {
            case .success(let artists):
                let tracks = artists.flatMap { $0.tracks }
                XCTAssertEqual(artists.count, 15)
                XCTAssertEqual(tracks.map { $0.name }.filter { $0.contains(term) }.count, tracks.count)
                XCTAssertEqual(tracks.count, 24)
            case .failure:
                // The result should not be an error! If so, fail the test and fix it.
                XCTAssertTrue(false)
            }
        }
    }

    func testInvalidSongStringReturnsError() {
        let term = "Some non valid string"
        repository.searchMusicVideos(song: term) { result in
            switch result {
            case .success:
                // The result should not be a succes! If so, fail the test and fix it.
                XCTAssertTrue(false)
            case .failure(let error):
                XCTAssertEqual(error as? SearchError, SearchError.parsingError)
            }
        }
    }
}
