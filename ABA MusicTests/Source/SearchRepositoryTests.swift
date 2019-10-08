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
    
    func testEmptyStringReturnsEmptyResponse() {
        let term = ""
    
        repository.searchMusicVideos(term) { result in
            switch result {
            case .success(let artists):
                XCTAssertEqual(artists.count, 0)
            case .failure(_):
                // The result should not be an error! If so, fail the test and fix it.
                XCTAssertTrue(false)
            }
        }
    }
    
    func testValidStringReturnsResponse_SingleArtist() {
        let term = "Beatles"
        
        repository.searchMusicVideos(term) { result in
            switch result {
            case .success(let artists):
                XCTAssertEqual(artists.count, 1)
                XCTAssertEqual(artists.map { $0.name.lowercased() }.filter { $0.contains(term.lowercased()) }.count, artists.count)
                XCTAssertEqual(artists.flatMap { $0.tracks }.count, 24)
            case .failure(_):
                // The result should not be an error! If so, fail the test and fix it.
                XCTAssertTrue(false)
            }
        }
    }
    
    func testValidStringReturnsResponse_MultipleArtists() {
        let term = "Jackson"
        
        repository.searchMusicVideos(term) { result in
            switch result {
            case .success(let artists):
                XCTAssertEqual(artists.count, 10)
                XCTAssertEqual(artists.map { $0.name.lowercased() }.filter { $0.contains(term.lowercased()) }.count, artists.count)
                XCTAssertEqual(artists.flatMap { $0.tracks }.count, 110)
            case .failure(_):
                // The result should not be an error! If so, fail the test and fix it.
                XCTAssertTrue(false)
            }
        }
    }
    
    func testInvalidStringReturnsError() {
        let term = "Some non valid string"
        repository.searchMusicVideos(term) { result in
            switch result {
            case .success(_):
                // The result should not be a succes! If so, fail the test and fix it.
                XCTAssertTrue(false)
            case .failure(let error):
                XCTAssertEqual(error as? SearchError, SearchError.parsingError)
            }
        }
    }
}
