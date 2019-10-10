import AlamofireImage
import DataSourceController
import UIKit

class SearchResultCollectionCell: UICollectionViewCell, NibReusable {
    static let identifier = "SearchResultCollectionCell"
    static let nibName = "SearchResultCollectionCell"

    private enum Constant {
        static let animationDuration: TimeInterval = 0.2
        static let placeholderImageName = "track-placeholder"
    }

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!

    private var viewModel: SearchResultCollectionViewModelType? {
        didSet { refreshView() }
    }

    private func refreshView() {
        guard let viewModel = viewModel else { return }
        nameLabel.text = viewModel.name
        if let url = viewModel.artworkUrl {
            imageView.af_setImage(
                withURL: url,
                placeholderImage: UIImage(named: Constant.placeholderImageName),
                imageTransition: .crossDissolve(Constant.animationDuration),
                runImageTransitionIfCached: true
            )
        } else {
            imageView.image = UIImage(named: Constant.placeholderImageName)
        }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}

extension SearchResultCollectionCell: CellView {
    func configure(with dataController: CellDataController) {
        guard let viewModel = dataController as? SearchResultCollectionViewModelType else { return }
        self.viewModel = viewModel
    }
}
