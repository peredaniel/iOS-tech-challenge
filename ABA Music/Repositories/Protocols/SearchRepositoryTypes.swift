protocol SearchByArtist {
    func searchMusicVideos(_: String, completion: @escaping (Result<[Artist], Error>) -> Void)
}
