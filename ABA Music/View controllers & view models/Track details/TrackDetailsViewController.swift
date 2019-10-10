import AVKit
import UIKit

class TrackDetailsViewController: UIViewController {
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var spinner: UIActivityIndicatorView!
    @IBOutlet private var artistNameLabel: UILabel!
    @IBOutlet private var trackNameLabel: UILabel!
    @IBOutlet private var genreLabel: UILabel!
    @IBOutlet private var countryLabel: UILabel!
    @IBOutlet private var releaseDateLabel: UILabel!

    var viewModel: TrackDetailsViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.layer.borderColor = UIColor.blue.cgColor
        containerView.layer.borderWidth = 1
        refreshView()
    }

    func refreshView() {
        guard let viewModel = viewModel else {
            fatalError("This screen's view model should be provided by the previous screen")
        }
        title = viewModel.trackName
        artistNameLabel.text = viewModel.artistName
        trackNameLabel.text = viewModel.trackName
        genreLabel.text = viewModel.trackGenre
        countryLabel.text = viewModel.trackCountry
        if let releaseDate = viewModel.releaseDate {
            releaseDateLabel.text = releaseDate
        } else {
            releaseDateLabel.isHidden = true
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let pvc = segue.destination as? TrackPlayerViewController,
            let previewUrl = viewModel?.previewUrl else {
            return
        }
        pvc.viewModel = TrackPlayerViewModel(url: previewUrl)
        pvc.playerDelegate = self
    }
}

extension TrackDetailsViewController: TrackPlayerViewControllerDelegate {
    func playerDidStartPlayback() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
    }
}
