import AlamofireImage
import DataSourceController
import UIKit

class SearchResultCollectionCell: UICollectionViewCell, NibReusable {
    static let identifier = "SearchResultCollectionCell"
    static let nibName = "SearchResultCollectionCell"

    private enum Constant {
        enum ImageView {
            static let placeholderImageName = "track-placeholder"
            static let cornerRadius: CGFloat = 5.0
            static let transitionDuration: TimeInterval = 0.2
        }

        enum CellLayer {
            static let cornerRadius: CGFloat = 10
            static let shadowOffset = CGSize(width: 1.5, height: 3.0)
            static let shadowRadius: CGFloat = 1.0
            static let shadowOpacity: Float = 0.75
        }
    }

    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var detailLabel: UILabel!

    private var viewModel: SearchResultCollectionViewModelType? {
        didSet { refreshView() }
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = Constant.CellLayer.cornerRadius
        layer.backgroundColor = UIColor.systemBackground.cgColor
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOffset = Constant.CellLayer.shadowOffset
        layer.shadowRadius = Constant.CellLayer.shadowRadius
        layer.shadowOpacity = Constant.CellLayer.shadowOpacity
        layer.masksToBounds = false

        imageView.layer.cornerRadius = Constant.ImageView.cornerRadius
    }

    private func refreshView() {
        guard let viewModel = viewModel else { return }
        nameLabel.text = viewModel.name
        detailLabel.text = viewModel.releaseDate
        if let url = viewModel.artworkUrl {
            imageView.af_setImage(
                withURL: url,
                placeholderImage: UIImage(named: Constant.ImageView.placeholderImageName),
                imageTransition: .crossDissolve(Constant.ImageView.transitionDuration),
                runImageTransitionIfCached: true
            )
        } else {
            imageView.image = UIImage(named: Constant.ImageView.placeholderImageName)
        }
    }
}

extension SearchResultCollectionCell: CellView {
    func configure(with dataController: CellDataController) {
        guard let viewModel = dataController as? SearchResultCollectionViewModelType else { return }
        self.viewModel = viewModel
    }
}
