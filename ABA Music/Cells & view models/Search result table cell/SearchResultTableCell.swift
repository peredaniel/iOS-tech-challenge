import DataSourceController
import UIKit

class SearchResultTableCell: UITableViewCell, NibReusable {
    static let identifier = "SearchResultTableCell"
    static let nibName = "SearchResultTableCell"

    var viewModel: SearchResultTableViewModelType? {
        didSet { refreshView() }
    }

    @IBOutlet private var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        SearchResultCollectionCell.register(in: collectionView)
    }

    @IBOutlet private var nameLabel: UILabel!

    private func refreshView() {
        guard let _ = viewModel else { return }
        nameLabel.text = viewModel?.name
        collectionView.dataSource = viewModel?.dataSource
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    override func prepareForReuse() {
        collectionView.scrollToItem(at: IndexPath.init(row: 0, section: 0), at: .left, animated: false)
    }
}

extension SearchResultTableCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO
    }
}

extension SearchResultTableCell: CellView {
    func configure(with dataController: CellDataController) {
        guard let viewModel = dataController as? SearchResultTableViewModelType else { return }
        self.viewModel = viewModel
    }
}
