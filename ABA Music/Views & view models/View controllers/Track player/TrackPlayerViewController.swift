import AVKit

protocol TrackPlayerViewControllerDelegate: AnyObject {
    func playerDidStartPlayback()
}

class TrackPlayerViewController: AVPlayerViewController {
    var viewModel: TrackPlayerViewModelType?
    weak var playerDelegate: TrackPlayerViewControllerDelegate?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        preparePlayerAndStartPlayback()
    }

    private func preparePlayerAndStartPlayback() {
        guard let viewModel = viewModel else {
            return
        }
        player = AVPlayer(playerItem: viewModel.playerItem)
        player?.play()
        playerDelegate?.playerDidStartPlayback()
    }
}
