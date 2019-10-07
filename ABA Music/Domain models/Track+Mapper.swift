extension Track {
    convenience init(searchResult: SearchResponse.Result) {
        self.init(
            identifier: searchResult.trackId,
            artist: Artist(searchResult: searchResult),
            name: searchResult.trackName,
            previewUrl: searchResult.previewUrl,
            artworkUrl100: searchResult.artworkUrl100,
            primaryGenreName: searchResult.primaryGenreName,
            country: searchResult.country,
            releaseDate: searchResult.releaseDate
        )
    }
}

