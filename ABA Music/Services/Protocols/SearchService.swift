protocol SearchService {
    func search(_: String, media: String, entity: String, attribute: String, limit: Int, completion: @escaping (Result<SearchResponse, Swift.Error>) -> Void)
}

enum SearchError: Swift.Error {
    case invalidURL
    case parsingError
}
