import DataSourceController
import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func viewModelFailedToFetchData(_: HomeViewModel)
}

protocol HomeViewModelType {
    var dataSource: DataSourceController { get }
    func detailsViewModel(forObjectAt _: IndexPath) -> TrackDetailsViewModelType?
    func fetchData(term: String)
}

class HomeViewModel {
    private var artists: [Artist] {
        didSet {
            dataSource.removeAllSections(notify: false)
            dataSource.add(section: Section(rows: artists))
        }
    }
    private weak var delegate: HomeViewModelDelegate?
    private let repository: SearchByArtist

    lazy var dataSource: DataSourceController = {
        let dataSource = DataSourceController(rows: [])
        dataSource.register(dataController: SearchResultTableViewModel.self, for: Artist.self)
        return dataSource
    }()

    init(delegate: HomeViewModelDelegate?) {
        self.delegate = delegate
        repository = SearchRepository(service: iTunesService())
        artists = []
    }
}

extension HomeViewModel: HomeViewModelType {
    func detailsViewModel(forObjectAt indexPath: IndexPath) -> TrackDetailsViewModelType? {
        guard let track = dataSource.modelObject(at: indexPath) as? Track else { return nil }
        return TrackDetailsViewModel(track: track)
    }

    func fetchData(term: String) {
        repository.searchMusicVideos(term) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let artists):
                self.artists = artists.sorted()
            case .failure(let error):
                self.delegate?.viewModelFailedToFetchData(self)
                print(error)
            }
        }
    }
}
