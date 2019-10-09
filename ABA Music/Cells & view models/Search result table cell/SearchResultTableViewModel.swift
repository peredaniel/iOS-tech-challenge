import DataSourceController
import Foundation

protocol SearchResultTableViewModelType {
    var dataSource: DataSourceController { get }
    var name: String { get }
}

class SearchResultTableViewModel: SearchResultTableViewModelType {
    private let artist: Artist

    let reuseIdentifier = SearchResultTableCell.identifier

    lazy var dataSource: DataSourceController = {
        let dataSource = DataSourceController(rows: artist.tracks)
        dataSource.register(dataController: SearchResultCollectionViewModel.self, for: Track.self)
        return dataSource
    }()

    var name: String {
        return artist.name
    }

    init(artist: Artist) {
        self.artist = artist
    }
}

extension SearchResultTableViewModel: CellDataController {
    static func populate(with model: Any) -> CellDataController {
        guard let artist = model as? Artist else {
            return SearchResultTableViewModel(artist: .fallback)
        }
        return SearchResultTableViewModel(artist: artist)
    }
}
