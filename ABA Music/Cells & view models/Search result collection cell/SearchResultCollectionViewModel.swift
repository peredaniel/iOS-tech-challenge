import DataSourceController
import Foundation

protocol SearchResultCollectionViewModelType {
    var artworkUrl: URL? { get }
    var name: String { get }
    var releaseDate: String? { get }
}

class SearchResultCollectionViewModel: SearchResultCollectionViewModelType {
    private enum Constant {
        static let dateFormat = "MMM dd, yyyy"
    }

    private let track: Track
    let reuseIdentifier = SearchResultCollectionCell.identifier

    init(track: Track) {
        self.track = track
    }

    var artworkUrl: URL? {
        return URL(string: track.artworkUrl100)
    }

    var name: String {
        return track.name
    }

    var releaseDate: String? {
        return DateFormatter(format: Constant.dateFormat).string(from: Date(timeIntervalSince1970: track.releaseDate))
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
