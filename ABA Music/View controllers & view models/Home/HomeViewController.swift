import Foundation
import UIKit

class HomeViewController: UIViewController {
    private enum Segue {
        static let trackDetails = "trackDetailsSegue"
    }

    @IBOutlet private var collectionView: UICollectionView!

    private lazy var viewModel: HomeViewModelType = {
        HomeViewModel(delegate: self)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ABA Music"
        ArtistCell.register(in: collectionView)
        viewModel.fetchData(term: "Jackson")
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return viewModel.modelCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ArtistCell.identifier,
            for: indexPath
        ) as! ArtistCell
        cell.viewModel = viewModel.viewModel(forRowAt: indexPath)
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        layout _: UICollectionViewLayout,
        sizeForItemAt _: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 180)
    }

    func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        minimumLineSpacingForSectionAt _: Int
    ) -> CGFloat {
        return 0
    }

    func collectionView(
        _: UICollectionView,
        layout _: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAt _: Int
    ) -> CGFloat {
        return 0
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
    func viewModel(_: HomeViewModel, didFetchData success: Bool) {
        if success {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } else {
            let alertController = UIAlertController(title: nil, message: "An error occurred while executing your search. Do you wish to try again?", preferredStyle: .alert)
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

    func viewModel(_: HomeViewModel, didSelectItemWith viewModel: TrackDetailsViewModelType) {
        performSegue(withIdentifier: Segue.trackDetails, sender: viewModel)
    }
}
