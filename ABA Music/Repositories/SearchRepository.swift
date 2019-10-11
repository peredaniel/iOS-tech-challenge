class SearchRepository {
    private enum SearchParameters {
        static let media = "musicVideo"
        static let entity = "musicVideo"
        static let limit: Int = 200
    }

    enum SearchScope: String {
        case album = "albumTerm"
        case artist = "artistTerm"
        case song = "songTerm"
    }

    private let service: SearchServiceType

    init(service: SearchServiceType) {
        self.service = service
    }
}

extension SearchRepository: SearchRepositoryType {
    func searchMusicVideos(
        album: String,
        completion: @escaping (Result<[Artist], Error>) -> Void
    ) {
        service.search(
            album,
            media: SearchParameters.media,
            entity: SearchParameters.entity,
            attribute: SearchScope.album.rawValue,
            limit: SearchParameters.limit
        ) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let searchResult):
                completion(.success(self.parseSearchResults(searchResult.results)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func searchMusicVideos(
        artist: String,
        completion: @escaping (Result<[Artist], Error>) -> Void
    ) {
        service.search(
            artist,
            media: SearchParameters.media,
            entity: SearchParameters.entity,
            attribute: SearchScope.artist.rawValue,
            limit: SearchParameters.limit
        ) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let searchResult):
                completion(.success(self.parseSearchResults(searchResult.results)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func searchMusicVideos(
        song: String,
        completion: @escaping (Result<[Artist], Error>) -> Void
    ) {
        service.search(
            song,
            media: SearchParameters.media,
            entity: SearchParameters.entity,
            attribute: SearchScope.song.rawValue,
            limit: SearchParameters.limit
        ) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let searchResult):
                completion(.success(self.parseSearchResults(searchResult.results)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

private extension SearchRepository {
    func parseSearchResults(_ results: [SearchResponse.Result]) -> [Artist] {
        var artists: [Artist] = []
        for result in results {
            guard result.previewUrl != nil else { continue }
            let artist = Artist(searchResult: result)
            if let foundArtist = artists.first(where: { $0.identifier == artist.identifier }) {
                foundArtist.tracks.append(Track(searchResult: result))
            } else {
                artist.tracks.append(Track(searchResult: result))
                artists.append(artist)
            }
        }
        return artists
    }
}
