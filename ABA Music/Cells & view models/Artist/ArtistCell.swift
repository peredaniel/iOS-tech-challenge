import UIKit

class ArtistCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .yellow
        label.backgroundColor = .blue
        label.font = UIFont(name: "Verdana", size: 14.0)
        return label
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        return collectionView
    }()

    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
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
        artistNameLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: 0).isActive = true
        artistNameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        artistNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        artistNameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        collectionView.register(TrackCell.self, forCellWithReuseIdentifier: "trackCell")
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
}

extension ArtistCell: UICollectionViewDataSource {
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return viewModel.tracksCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trackCell", for: indexPath) as! TrackCell
        cell.viewModel = viewModel.viewModel(forObjectAt: indexPath)
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.borderWidth = 1.0
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.25, height: collectionView.frame.height / 1.5)
    }
}
