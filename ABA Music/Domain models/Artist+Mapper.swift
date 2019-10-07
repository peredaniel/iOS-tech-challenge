extension Artist {
    convenience init(searchResult: SearchResponse.Result) {
        self.init(
            identifier: searchResult.artistId,
            name: searchResult.artistName,
            tracks: []
        )
    }
}
