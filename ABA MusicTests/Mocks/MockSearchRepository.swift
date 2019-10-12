@testable import ABA_Music
import Foundation

class MockSearchRepository: SearchRepositoryType {
    func searchMusicVideos(album: String, completion: @escaping (Result<[Artist], Error>) -> Void) {
        if album.isEmpty {
            completion(.success([]))
        } else if album == "error" {
            completion(.failure(SearchServiceError.invalidQueryParameters))
        } else {
            completion(.success((0...2).map { Artist.generateArtist(index: $0) }))
        }
    }

    func searchMusicVideos(artist: String, completion: @escaping (Result<[Artist], Error>) -> Void) {
        if artist.isEmpty {
            completion(.success([]))
        } else if artist == "error" {
            completion(.failure(SearchServiceError.invalidQueryParameters))
        } else {
            completion(.success((0...4).map { Artist.generateArtist(index: $0) }))
        }
    }

    func searchMusicVideos(song: String, completion: @escaping (Result<[Artist], Error>) -> Void) {
        if song.isEmpty {
            completion(.success([]))
        } else if song == "error" {
            completion(.failure(SearchServiceError.invalidQueryParameters))
        } else {
            completion(.success([Artist.generateArtist(index: 0)]))
        }
    }
}
