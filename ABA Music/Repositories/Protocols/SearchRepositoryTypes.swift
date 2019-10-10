protocol SearchRepositoryType {
    func searchMusicVideos(album: String, completion: @escaping (Result<[Artist], Error>) -> Void)
    func searchMusicVideos(artist: String, completion: @escaping (Result<[Artist], Error>) -> Void)
    func searchMusicVideos(song: String, completion: @escaping (Result<[Artist], Error>) -> Void)
}
