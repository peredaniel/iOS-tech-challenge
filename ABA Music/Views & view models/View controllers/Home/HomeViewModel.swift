import DataSourceController
import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func viewModelFailedToFetchData(_: HomeViewModelType)
    func viewModel(_: HomeViewModelType, didSelectItemWithViewModel _: TrackDetailsViewModelType)
}

protocol HomeViewModelType {
    var dataSource: DataSourceController { get }
    var delegate: HomeViewModelDelegate? { get set }
    var searchTerm: String { get }
    var searchScopeIndex: Int { get }
    func updateSearchTerm(_: String?)
    func updateSearchScope(_: Int)
}

class HomeViewModel {
    private var artists: [Artist] {
        didSet {
            dataSource.removeAllSections(notify: false)
            let rowEntries = artists.map { SearchResultTableCellData(artist: $0, delegate: self) }
            dataSource.add(section: Section(rows: rowEntries))
        }
    }

    private let repository: SearchRepositoryType
    private var searchScope: SearchRepository.SearchScope = .artist {
        didSet { performSearch() }
    }

    private(set) var searchTerm: String {
        didSet { performSearch() }
    }

    lazy var dataSource: DataSourceController = {
        let dataSource = DataSourceController(rows: [])
        dataSource.register(
            dataController: SearchResultTableViewModel.self,
            for: SearchResultTableCellData.self
        )
        return dataSource
    }()

    weak var delegate: HomeViewModelDelegate?

    init(repository: SearchRepositoryType) {
        self.repository = repository
        artists = []
        searchTerm = ""
    }
}

extension HomeViewModel: HomeViewModelType {
    var searchScopeIndex: Int {
        return searchScope.invValue
    }

    func performSearch() {
        switch searchScope {
        case .album:
            repository.searchMusicVideos(album: searchTerm) { [weak self] result in
                self?.handleSearchResult(result)
            }
        case .artist:
            repository.searchMusicVideos(artist: searchTerm) { [weak self] result in
                self?.handleSearchResult(result)
            }
        case .song:
            repository.searchMusicVideos(song: searchTerm) { [weak self] result in
                self?.handleSearchResult(result)
            }
        }
    }

    func updateSearchTerm(_ term: String?) {
        if let term = term {
            searchTerm = term
        }
    }

    func updateSearchScope(_ index: Int) {
        if let newScope = SearchRepository.SearchScope(intValue: index) {
            searchScope = newScope
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

private extension HomeViewModel {
    func handleSearchResult(_ result: Result<[Artist], Error>) {
        switch result {
        case .success(let artists):
            self.artists = artists.sorted()
        case .failure(let error):
            delegate?.viewModelFailedToFetchData(self)
            print(error)
        }
    }
}

private extension SearchRepository.SearchScope {
    init?(intValue: Int) {
        switch intValue {
        case 0: self = .artist
        case 1: self = .song
        case 2: self = .album
        default: return nil
        }
    }

    var invValue: Int {
        switch self {
        case .artist: return 0
        case .song: return 1
        case .album: return 2
        }
    }
}
