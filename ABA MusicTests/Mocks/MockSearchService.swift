@testable import ABA_Music
import Foundation

class MockSearchService: SearchServiceType {
    func search(
        _ term: String,
        media _: String = "",
        entity _: String = "",
        attribute: String = "",
        limit _: Int = 0,
        completion: @escaping (Result<SearchResponse, Error>) -> Void
    ) {
        guard let data = loadFromBundle("\(term)_\(attribute)"),
            let response = try? JSONDecoder().decode(SearchResponse.self, from: data) else {
            completion(.failure(SearchServiceError.parsingError))
            return
        }
        completion(.success(response))
    }
}

private extension MockSearchService {
    func loadFromBundle(_ fileName: String) -> Data? {
        var file = fileName
        if file.starts(with: "_") {
            file = "EmptyResponse" + fileName
        }
        guard let url = Bundle(for: MockSearchService.self).url(forResource: file, withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
            print("Could not read JSON file!")
            return nil
        }
        return data
    }
}
