import Foundation
import UIKit

class HomeViewController: UIViewController {
    private lazy var viewModel: HomeViewModelType = {
        HomeViewModel(delegate: self)
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        print("Init")
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ABA Music"
        view.backgroundColor = .gray
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.backgroundColor = .lightGray
        ArtistCell.register(in: collectionView)
        collectionView.showsVerticalScrollIndicator = false

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

extension HomeViewController: UICollectionViewDelegateFlowLayout {
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

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func viewModel(_: HomeViewModel, didFetchData success: Bool) {
        if success {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } else {
            // TODO: Implement error message
        }
    }

    func viewModel(_: HomeViewModel, didSelectItemWith viewModel: TrackDetailsViewModelType) {
        let trackViewController = TrackDetailsViewController()
        trackViewController.viewModel = viewModel
        navigationController?.pushViewController(trackViewController, animated: true)
    }
}
