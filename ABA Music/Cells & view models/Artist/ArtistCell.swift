import UIKit

class ArtistCell: UICollectionViewCell, Reusable {
    static let identifier = "artistCell"

    lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .yellow
        label.backgroundColor = .blue
        label.font = UIFont(name: "Verdana", size: 14.0)
        return label
    }()

    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()

    var viewModel: ArtistCellViewModelType! {
        didSet {
            refreshView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        addSubview(artistNameLabel)
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        artistNameLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor).isActive = true
        artistNameLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        artistNameLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        artistNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        TrackCell.register(in: collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .lightGray
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func refreshView() {
        artistNameLabel.text = viewModel?.name
        collectionView.reloadData()
    }

    static func register(in collectionView: UICollectionView) {
        collectionView.register(ArtistCell.self, forCellWithReuseIdentifier: identifier)
    }
}

extension ArtistCell: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return viewModel.tracksCount
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TrackCell.identifier,
            for: indexPath
        ) as! TrackCell
        cell.viewModel = viewModel.viewModel(forObjectAt: indexPath)
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.borderWidth = 1.0
        return cell
    }
}

extension ArtistCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout _: UICollectionViewLayout,
        sizeForItemAt _: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.25, height: collectionView.frame.height / 1.5)
    }
}
