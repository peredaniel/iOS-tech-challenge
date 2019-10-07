class SearchRepository {
    private enum DefaultSearchParameters {
        static let media = "musicVideo"
        static let entity = "musicVideo"
        static let attribute = "artistTerm"
        static let limit: Int = 200
    }
    private let service: SearchService

    init(service: SearchService) {
        self.service = service
    }
}

extension SearchRepository: SearchByArtist {
    func searchMusicVideos(
        _ artist: String,
        completion: @escaping (Result<[Artist], Error>) -> Void
    ) {
        service.search(
            artist,
            media: DefaultSearchParameters.media,
            entity: DefaultSearchParameters.entity,
            attribute: DefaultSearchParameters.attribute,
            limit: DefaultSearchParameters.limit
        ) { response in
            switch response {
            case .success(let searchResult):
                var artists: [Artist] = []
                for result in searchResult.results {
                    let artist = Artist(searchResult: result)
                    if let foundArtist = artists.first(where: { $0.identifier == artist.identifier }) {
                        foundArtist.tracks.append(Track(searchResult: result))
                    } else {
                        artist.tracks.append(Track(searchResult: result))
                        artists.append(artist)
                    }
                }
                completion(.success(artists))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
