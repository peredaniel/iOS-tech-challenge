import DataSourceController
import Foundation
import UIKit

class HomeViewController: UIViewController {
    private enum Segue {
        static let trackDetails = "trackDetailsSegue"
    }

    @IBOutlet private var tableView: UITableView!

    private lazy var viewModel: HomeViewModelType = {
        HomeViewModel(delegate: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ABA Music"
        configureCollectionView()
        viewModel.fetchData(term: "Jackson")
    }

    private func configureCollectionView() {
        SearchResultTableCell.register(in: tableView)
        tableView.dataSource = viewModel.dataSource
        viewModel.dataSource.delegate = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tdvc = segue.destination as? TrackDetailsViewController,
            let viewModel = sender as? TrackDetailsViewModelType else {
            return
        }
        tdvc.viewModel = viewModel
    }
}


extension HomeViewController: HomeViewModelDelegate {
    func viewModelFailedToFetchData(_: HomeViewModel) {
        let alertController = UIAlertController(
            title: nil,
            message: "An error occurred while executing your search. Do you wish to try again?",
            preferredStyle: .alert
        )
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.dismiss(animated: true) {
                self?.viewModel.fetchData(term: "Jackson")
            }
        }
        alertController.addAction(retryAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension HomeViewController: DataSourceControllerDelegate {
    func dataSourceWasMutated(_: DataSourceController) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
