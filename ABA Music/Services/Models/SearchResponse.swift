struct SearchResponse: Decodable {
    struct Result: Decodable {
        let artistId: Int
        let artistName: String
        let artworkUrl100: String
        let country: String
        let previewUrl: String
        let primaryGenreName: String
        let releaseDate: String
        let trackId: Int
        let trackName: String
    }

    let resultCount: Int
    let results: [SearchResponse.Result]
}
