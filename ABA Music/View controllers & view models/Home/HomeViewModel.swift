import DataSourceController
import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func viewModelFailedToFetchData(_: HomeViewModelType)
    func viewModel(_: HomeViewModelType, didSelectItemWithViewModel _: TrackDetailsViewModelType)
}

protocol HomeViewModelType {
    var dataSource: DataSourceController { get }
    func fetchData(term: String)
}

class HomeViewModel {
    private var artists: [Artist] {
        didSet {
            dataSource.removeAllSections(notify: false)
            let rowEntries = artists.map { SearchResultTableCellData(artist: $0, delegate: self) }
            dataSource.add(section: Section(rows: rowEntries))
        }
    }
    private weak var delegate: HomeViewModelDelegate?
    private let repository: SearchByArtist

    lazy var dataSource: DataSourceController = {
        let dataSource = DataSourceController(rows: [])
        dataSource.register(
            dataController: SearchResultTableViewModel.self,
            for: SearchResultTableCellData.self
        )
        return dataSource
    }()

    init(delegate: HomeViewModelDelegate?) {
        self.delegate = delegate
        repository = SearchRepository(service: iTunesService())
        artists = []
    }
}

extension HomeViewModel: HomeViewModelType {
    func fetchData(term: String) {
        repository.searchMusicVideos(artist: term) { [weak self] result in
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

extension HomeViewModel: SearchResultTableDelegate {
    func didSelectTrack(_ track: Track) {
        delegate?.viewModel(
            self,
            didSelectItemWithViewModel: TrackDetailsViewModel(track: track)
        )
    }
}
