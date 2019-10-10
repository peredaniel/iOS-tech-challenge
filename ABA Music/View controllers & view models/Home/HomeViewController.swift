import DataSourceController
import Foundation
import UIKit

class HomeViewController: UIViewController {
    private enum Segue {
        static let trackDetails = "trackDetailsSegue"
    }

    private enum Constant {
        static let searchDelay: TimeInterval = 0.5
    }

    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var searchBar: UISearchBar!

    private var timer: Timer?
    private var searchBarInitialLeftView: UIView?
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.hidesWhenStopped = true
        return spinner
    }()

    private lazy var viewModel: HomeViewModelType = {
        HomeViewModel(delegate: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ABA Music"
        configureSearchBar()
        configureTableView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
    }

    override func prepare(
        for segue: UIStoryboardSegue,
        sender: Any?
    ) {
        guard let tdvc = segue.destination as? TrackDetailsViewController,
            let viewModel = sender as? TrackDetailsViewModelType else {
            return
        }
        tdvc.viewModel = viewModel
    }
}

private extension HomeViewController {
    func configureTableView() {
        SearchResultTableCell.register(in: tableView)
        tableView.dataSource = viewModel.dataSource
        viewModel.dataSource.delegate = self
    }

    func configureSearchBar() {
        searchBar.selectedScopeButtonIndex = viewModel.searchScopeIndex
        searchBarInitialLeftView = searchBar.searchTextField.leftView
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func viewModelFailedToFetchData(_: HomeViewModelType) {
        let alertController = UIAlertController(
            title: nil,
            message: "An error occurred while executing your search. Do you wish to try again?",
            preferredStyle: .alert
        )
        let retryAction = UIAlertAction(
            title: "Ok",
            style: .default
        ) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(retryAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }

    func viewModel(
        _: HomeViewModelType,
        didSelectItemWithViewModel viewModel: TrackDetailsViewModelType
    ) {
        performSegue(withIdentifier: Segue.trackDetails, sender: viewModel)
    }
}

extension HomeViewController: DataSourceControllerDelegate {
    func dataSourceWasMutated(_: DataSourceController) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.spinner.stopAnimating()
            self?.searchBar.searchTextField.leftView = self?.searchBarInitialLeftView
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(
        _: UISearchBar,
        textDidChange searchText: String
    ) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(
            withTimeInterval: Constant.searchDelay,
            repeats: false
        ) { [weak self] _ in
            self?.searchBar.searchTextField.leftView = self?.spinner
            self?.spinner.startAnimating()
            self?.viewModel.updateSearchTerm(searchText)
            self?.timer?.invalidate()
        }
    }

    func searchBar(
        _ searchBar: UISearchBar,
        selectedScopeButtonIndexDidChange selectedScope: Int
    ) {
        searchBar.searchTextField.leftView = spinner
        spinner.startAnimating()
        viewModel.updateSearchScope(selectedScope)
    }
}
