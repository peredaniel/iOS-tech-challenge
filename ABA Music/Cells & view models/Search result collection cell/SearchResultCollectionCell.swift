import AlamofireImage
import DataSourceController
import UIKit

class SearchResultCollectionCell: UICollectionViewCell, NibReusable {
    static let identifier = "SearchResultCollectionCell"
    static let nibName = "SearchResultCollectionCell"

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!

    private var viewModel: SearchResultCollectionViewModelType? {
        didSet { refreshView() }
    }

    private func refreshView() {
        guard let viewModel = viewModel else { return }
        nameLabel.text = viewModel.name
        if let url = viewModel.artworkUrl {
            imageView.af_setImage(withURL: url)
        } else {
            imageView.image = nil
        }
    }
}

extension SearchResultCollectionCell: CellView {
    func configure(with dataController: CellDataController) {
        guard let viewModel = dataController as? SearchResultCollectionViewModelType else { return }
        self.viewModel = viewModel
    }
}
