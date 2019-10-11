import DataSourceController
import UIKit

class SearchResultTableCell: UITableViewCell, NibReusable {
    static let identifier = "SearchResultTableCell"
    static let nibName = "SearchResultTableCell"

    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var nameLabel: UILabel!

    var viewModel: SearchResultTableViewModelType? {
        didSet { refreshView() }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        SearchResultCollectionCell.register(in: collectionView)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        guard let numberOfRows = viewModel?.dataSource.totalRowCount, numberOfRows > 0 else { return }
        collectionView.scrollToItem(
            at: IndexPath(row: 0, section: 0),
            at: .left,
            animated: false
        )
    }

    private func refreshView() {
        guard let _ = viewModel else { return }
        nameLabel.text = viewModel?.name
        collectionView.dataSource = viewModel?.dataSource
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension SearchResultTableCell: UICollectionViewDelegate {
    func collectionView(
        _: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        viewModel?.didSelectItem(at: indexPath)
    }
}

extension SearchResultTableCell: CellView {
    func configure(with dataController: CellDataController) {
        guard let viewModel = dataController as? SearchResultTableViewModelType else { return }
        self.viewModel = viewModel
    }
}
