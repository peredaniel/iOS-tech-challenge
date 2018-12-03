import UIKit

protocol ArtistCollectionViewCellDelegate {
    func didPressTrack(_ track: Track)
}

class ArtistCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, TrackCollectionViewCellDelegate {
    
    lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .yellow
        label.backgroundColor = .blue
        label.font = UIFont.init(name: "Verdana", size: 14.0)
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
    
    var delegate: ArtistCollectionViewCellDelegate?
    
    var artist: Artist? {
        didSet {
            artistNameLabel.text = artist!.artistName
            collectionView.reloadData()
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
        collectionView.register(TrackCollectionViewCell.self, forCellWithReuseIdentifier: "trackCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let artist = artist {
            return artist.tracks.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trackCell", for: indexPath) as! TrackCollectionViewCell
        cell.track = artist!.tracks[indexPath.row]
        cell.delegate = self
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.borderWidth = 1.0
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.25, height: collectionView.frame.height / 1.5)
    }
    
    func didPressTrack(_ track: Track) {
        delegate?.didPressTrack(track)
    }
}
