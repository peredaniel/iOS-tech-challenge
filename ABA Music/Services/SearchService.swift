import Foundation

enum SearchServiceError: Swift.Error {
    case invalidURL
    case invalidQueryParameters
    case parsingError
}

class SearchService {
    private enum QueryItemKey: String {
        case attribute
        case entity
        case limit
        case media
        case term
    }

    private let endpoint = "/search"
    private let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
}

extension SearchService: SearchServiceType {
    func search(
        _ term: String,
        media: String,
        entity: String,
        attribute: String,
        limit: Int,
        completion: @escaping (Result<SearchResponse, Error>) -> Void
    ) {
        guard var urlComponents = URLComponents(string: baseUrl) else {
            completion(.failure(SearchServiceError.invalidURL))
            return
        }

        urlComponents.path = endpoint

        urlComponents.queryItems = [
            URLQueryItem(
                name: QueryItemKey.term.rawValue,
                value: term.replacingOccurrences(of: " ", with: "+")
            ),
            URLQueryItem(name: QueryItemKey.media.rawValue, value: media),
            URLQueryItem(name: QueryItemKey.entity.rawValue, value: entity),
            URLQueryItem(name: QueryItemKey.attribute.rawValue, value: attribute),
            URLQueryItem(name: QueryItemKey.limit.rawValue, value: "\(limit)")
        ]

        guard let url = urlComponents.url else {
            completion(.failure(SearchServiceError.invalidQueryParameters))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil, let data = data else {
                completion(.failure(error!))
                return
            }
            if let result = try? JSONDecoder().decode(SearchResponse.self, from: data) {
                completion(.success(result))
            } else {
                completion(.failure(SearchServiceError.parsingError))
            }
        }.resume()
    }
}
