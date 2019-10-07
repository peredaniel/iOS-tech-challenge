import Foundation
import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ArtistCollectionViewCellDelegate {
    var artists: [Artist] = []
    var tableView: UITableView!
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        return cv
    }()

    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        return layout
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
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionView.backgroundColor = UIColor.lightGray
        collectionView.register(ArtistCollectionViewCell.self, forCellWithReuseIdentifier: "artistCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        fetchData(term: "Jackson")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }

    func fetchData(term: String) {
        if let urlString = "https://itunes.apple.com/search?term=\(term)&media=musicVideo&entity=musicVideo&attribute=artistTerm&limit=200".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: urlString) {
                let task = URLSession.shared.dataTask(with: url) { data, _, error in
                    guard let data = data else { return }
                    do {
                        if let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            if let results = dict["results"] as? [[String: Any]] {
                                results.forEach { track in
                                    self.addTracks(track: track)
                                }
                                self.artists.sorted(by: { (a1, b1) -> Bool in
                                    a1.artistName.compare(b1.artistName) == .orderedAscending
                                })
                                DispatchQueue.main.async {
                                    self.collectionView.reloadData()
                                }
                            }
                        }

                    } catch var error {
                        print(error.localizedDescription)
                    }
                }
                task.resume()
            }
        }
    }

    func addTracks(track: [String: Any]) {
        if let artistId = track["artistId"] as? Int,
            let artistName = track["artistName"] as? String,
            let trackId = track["trackId"] as? Int,
            let trackName = track["trackName"] as? String,
            let previewUrl = track["previewUrl"] as? String,
            let artworkUrl100 = track["artworkUrl100"] as? String,
            let primaryGenreName = track["primaryGenreName"] as? String,
            let country = track["country"] as? String,
            let releaseDate = track["releaseDate"] as? String {
            let artist = Artist(artistId: artistId, artistName: artistName, tracks: [])
            let track = Track(trackId: trackId, artist: artist, artistName: artistName, trackName: trackName, previewUrl: previewUrl, artworkUrl100: artworkUrl100, primaryGenreName: primaryGenreName, country: country, releaseDate: releaseDate)

            if let foundArtist = (artists.filter { $0.artistId == artist.artistId }).first {
                foundArtist.tracks.append(track)
            } else {
                artist.tracks.append(track)
                artists.append(artist)
            }
        }
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return artists.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "artistCell", for: indexPath) as! ArtistCollectionViewCell
        cell.artist = artists[indexPath.item]
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 180)
    }

    func didPressTrack(_ track: Track) {
        let trackViewController = TrackViewController(track: track)
        navigationController?.pushViewController(trackViewController, animated: true)
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }

    func collectionView(_: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        return 0
    }
}
