import Alamofire
import AVKit
import UIKit

class TrackDetailsViewController: UIViewController {
    private enum Constant {
        static let placeholderImageName = "track-placeholder"
        static let transitionDuration: TimeInterval = 0.2
    }

    @IBOutlet private var containerView: UIView!
    @IBOutlet private var spinner: UIActivityIndicatorView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var artistNameLabel: UILabel!
    @IBOutlet private var trackNameLabel: UILabel!
    @IBOutlet private var genreLabel: UILabel!
    @IBOutlet private var countryLabel: UILabel!
    @IBOutlet private var releaseDateLabel: UILabel!
    @IBOutlet private var errorLabel: UILabel!

    var viewModel: TrackDetailsViewModelType?

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .allButUpsideDown
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshView()
    }

    override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
        guard let pvc = segue.destination as? TrackPlayerViewController,
            let previewUrl = viewModel?.previewUrl else {
            spinner.stopAnimating()
            errorLabel.isHidden = false
            return
        }
        pvc.viewModel = TrackPlayerViewModel(url: previewUrl)
        pvc.playerDelegate = self
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        let isLandscape = size.width > size.height
        navigationController?.navigationBar.isHidden = isLandscape
        view.backgroundColor = isLandscape ? .black : .systemBackground
    }

    private func refreshView() {
        guard let viewModel = viewModel else {
            fatalError("This screen's view model should be provided by the previous screen")
        }
        containerView.layer.cornerRadius = 5.0
        title = viewModel.trackName
        if let url = viewModel.artworkUrl {
            imageView.af_setImage(
                withURL: url,
                placeholderImage: UIImage(named: Constant.placeholderImageName),
                imageTransition: .crossDissolve(Constant.transitionDuration),
                runImageTransitionIfCached: true
            )
        } else {
            imageView.image = UIImage(named: Constant.placeholderImageName)
        }
        artistNameLabel.text = viewModel.artistName
        trackNameLabel.text = viewModel.trackName
        genreLabel.text = "Genre: " + viewModel.trackGenre
        countryLabel.text = "Country: " + viewModel.trackCountry
        if let releaseDate = viewModel.releaseDate {
            releaseDateLabel.text = "Release date: " + releaseDate
        } else {
            releaseDateLabel.isHidden = true
        }
    }
}

extension TrackDetailsViewController: TrackPlayerViewControllerDelegate {
    func playerDidStartPlayback() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
    }
}
