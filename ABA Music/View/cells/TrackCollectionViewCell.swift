import AlamofireImage
import UIKit

protocol TrackCollectionViewCellDelegate {
    func didPressTrack(_ track: Track)
}

class TrackCollectionViewCell: UICollectionViewCell {
    var delegate: TrackCollectionViewCellDelegate?

    lazy var trackNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Verdana", size: 8.0)
        return label
    }()

    lazy var trackImageView: UIImageView = {
        let trackImageView = UIImageView()
        trackImageView.layer.cornerRadius = 5
        trackImageView.clipsToBounds = true
        return trackImageView
    }()

    var track: Track? {
        didSet {
            trackNameLabel.text = track!.name
            trackImageView.af_setImage(withURL: URL(string: track!.artworkUrl100)!)
            let gesture = UITapGestureRecognizer(target: self, action: #selector(pressTrack))
            self.addGestureRecognizer(gesture)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(trackImageView)
        addSubview(trackNameLabel)
        trackImageView.translatesAutoresizingMaskIntoConstraints = false
        trackImageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        trackImageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        trackImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        trackImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        trackNameLabel.translatesAutoresizingMaskIntoConstraints = false
        trackNameLabel.topAnchor.constraint(equalTo: trackImageView.topAnchor, constant: 0).isActive = true
        trackNameLabel.bottomAnchor.constraint(equalTo: trackImageView.bottomAnchor, constant: 0).isActive = true
        trackNameLabel.leftAnchor.constraint(equalTo: trackImageView.leftAnchor, constant: 0).isActive = true
        trackNameLabel.rightAnchor.constraint(equalTo: trackImageView.rightAnchor, constant: 0).isActive = true
        backgroundColor = UIColor.lightGray
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func pressTrack() {
        delegate?.didPressTrack(track!)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 5
    }
}
