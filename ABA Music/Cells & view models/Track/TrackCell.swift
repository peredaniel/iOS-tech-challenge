import AlamofireImage
import UIKit

class TrackCell: UICollectionViewCell, Reusable {
    static let identifier = "trackCell"
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Verdana", size: 8.0)
        return label
    }()

    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()

    var viewModel: TrackCellViewModelType! {
        didSet {
            refreshView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(nameLabel)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 0).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 0).isActive = true
        nameLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: 0).isActive = true
        backgroundColor = UIColor.lightGray
    }

    func refreshView() {
        nameLabel.text = viewModel.name
        if let url = viewModel?.artworkUrl {
            imageView.af_setImage(withURL: url)
        } else {
            imageView.image = nil
        }
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pressTrack))
        addGestureRecognizer(gesture)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func pressTrack() {
        viewModel.cellTapped()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 5
    }

    static func register(in collectionView: UICollectionView) {
        collectionView.register(TrackCell.self, forCellWithReuseIdentifier: identifier)
    }
}
