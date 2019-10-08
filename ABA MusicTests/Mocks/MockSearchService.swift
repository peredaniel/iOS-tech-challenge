@testable import ABA_Music
import Foundation

class MockSearchService: SearchService {
    func search(
        _ term: String,
        media _: String = "",
        entity _: String = "",
        attribute _: String = "",
        limit _: Int = 0,
        completion: @escaping (Result<SearchResponse, Error>) -> Void
    ) {
        guard let data = loadFromBundle(term),
            let response = try? JSONDecoder().decode(SearchResponse.self, from: data) else {
            completion(.failure(SearchError.parsingError))
            return
        }
        completion(.success(response))
    }
}

private extension MockSearchService {
    func loadFromBundle(_ fileName: String) -> Data? {
        var file = fileName
        if file.isEmpty {
            file = "EmptyResponse"
        }
        guard let url = Bundle(for: MockSearchService.self).url(forResource: file, withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
            print("Could not read JSON file!")
            return nil
        }
        return data
    }
}
