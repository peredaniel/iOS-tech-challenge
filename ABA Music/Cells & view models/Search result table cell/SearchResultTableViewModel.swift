import DataSourceController
import Foundation

protocol SearchResultTableDelegate: AnyObject {
    func didSelectTrack(_: Track)
}

protocol SearchResultTableViewModelType {
    var dataSource: DataSourceController { get }
    var name: String { get }
    func didSelectItem(at _: IndexPath)
}

class SearchResultTableViewModel: SearchResultTableViewModelType {
    let reuseIdentifier = SearchResultTableCell.identifier
    private let artist: Artist
    private weak var delegate: SearchResultTableDelegate?

    lazy var dataSource: DataSourceController = {
        let dataSource = DataSourceController(rows: artist.tracks)
        dataSource.register(
            dataController: SearchResultCollectionViewModel.self,
            for: Track.self
        )
        return dataSource
    }()

    var name: String {
        return artist.name
    }

    init(artist: Artist, delegate: SearchResultTableDelegate?) {
        self.artist = artist
        self.delegate = delegate
    }

    func didSelectItem(at indexPath: IndexPath) {
        guard let track = dataSource.modelObject(at: indexPath) as? Track else { return }
        delegate?.didSelectTrack(track)
    }
}

extension SearchResultTableViewModel: CellDataController {
    static func populate(with model: Any) -> CellDataController {
        guard let data = model as? SearchResultTableCellData else {
            return SearchResultTableViewModel(artist: .fallback, delegate: nil)
        }
        return SearchResultTableViewModel(artist: data.artist, delegate: data.delegate)
    }
}
