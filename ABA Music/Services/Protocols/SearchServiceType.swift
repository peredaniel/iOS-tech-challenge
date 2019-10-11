protocol SearchServiceType {
    func search(_: String, media: String, entity: String, attribute: String, limit: Int, completion: @escaping (Result<SearchResponse, Error>) -> Void)
}
