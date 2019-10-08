import Foundation

class iTunesService {
    private enum QueryItemKey: String {
        case attribute
        case entity
        case limit
        case media
        case term
    }

    private let baseUrl = "https://itunes.apple.com/search"
}

extension iTunesService: SearchService {
    func search(
        _ term: String,
        media: String,
        entity: String,
        attribute: String,
        limit: Int,
        completion: @escaping (Result<SearchResponse, Swift.Error>) -> Void
    ) {
        guard var urlComponents = URLComponents(string: baseUrl) else {
            completion(.failure(SearchError.invalidURL))
            return
        }

        urlComponents.queryItems = [
            URLQueryItem(name: QueryItemKey.term.rawValue, value: term),
            URLQueryItem(name: QueryItemKey.media.rawValue, value: media),
            URLQueryItem(name: QueryItemKey.entity.rawValue, value: entity),
            URLQueryItem(name: QueryItemKey.attribute.rawValue, value: attribute),
            URLQueryItem(name: QueryItemKey.limit.rawValue, value: "\(limit)")
        ]

        guard let url = urlComponents.url else {
            completion(.failure(SearchError.invalidURL))
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
                completion(.failure(SearchError.parsingError))
            }
        }.resume()
    }
}
