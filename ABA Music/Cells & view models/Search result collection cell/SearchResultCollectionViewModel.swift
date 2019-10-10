import DataSourceController
import Foundation

protocol SearchResultCollectionViewModelType {
    var artworkUrl: URL? { get }
    var name: String { get }
}

class SearchResultCollectionViewModel {
    private let track: Track
    let reuseIdentifier = SearchResultCollectionCell.identifier

    init(track: Track) {
        self.track = track
    }
}

extension SearchResultCollectionViewModel: SearchResultCollectionViewModelType {
    var artworkUrl: URL? {
        return URL(string: track.artworkUrl100)
    }

    var name: String {
        return track.name
    }
}

extension SearchResultCollectionViewModel: CellDataController {
    static func populate(with model: Any) -> CellDataController {
        guard let track = model as? Track else {
            return SearchResultCollectionViewModel(track: .fallback)
        }
        return SearchResultCollectionViewModel(track: track)
    }
}
