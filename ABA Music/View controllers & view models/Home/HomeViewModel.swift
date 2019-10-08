import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func viewModel(_: HomeViewModel, didSelectItemWith viewModel: TrackDetailsViewModelType)
    func viewModel(_: HomeViewModel, didFetchData success: Bool)
}

protocol HomeViewModelType {
    var modelCount: Int { get }
    func detailsViewModel(forObjectAt _: IndexPath) -> TrackDetailsViewModelType?
    func fetchData(term: String)
    func viewModel(forRowAt _: IndexPath) -> ArtistCellViewModelType?
}

class HomeViewModel {
    private var artists: [Artist]
    private weak var delegate: HomeViewModelDelegate?
    private let repository: SearchByArtist

    init(delegate: HomeViewModelDelegate?) {
        self.delegate = delegate
        repository = SearchRepository(service: iTunesService())
        artists = []
    }
}

extension HomeViewModel: HomeViewModelType {
    var modelCount: Int {
        return artists.count
    }

    func detailsViewModel(forObjectAt _: IndexPath) -> TrackDetailsViewModelType? {
        return nil
    }

    func fetchData(term: String) {
        repository.searchMusicVideos(term) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let artists):
                self.artists = artists.sorted()
                self.delegate?.viewModel(self, didFetchData: true)
            case .failure(let error):
                self.delegate?.viewModel(self, didFetchData: false)
                print(error)
            }
        }
    }
    
    func viewModel(forRowAt indexPath: IndexPath) -> ArtistCellViewModelType? {
        guard indexPath.row < artists.count else { return nil }
        let artist = artists[indexPath.row]
        return ArtistCellViewModel(artist: artist, delegate: self)
    }
}


extension HomeViewModel: ArtistCellViewModelDelegate {
    func didPressTrack(_ track: Track) {
        delegate?.viewModel(
            self,
            didSelectItemWith: TrackDetailsViewModel(track: track)
        )
    }
}
