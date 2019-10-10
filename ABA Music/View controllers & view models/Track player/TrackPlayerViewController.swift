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
            fatalError("This screen's view model should be provided by the previous screen")
        }
        if player?.currentItem != nil {
            player?.seek(to: .zero) { [weak self] _ in
                guard let self = self else { return }
                self.player?.play()
                self.playerDelegate?.playerDidStartPlayback()
            }
        } else {
            if player == nil {
                player = AVPlayer(playerItem: viewModel.playerItem)
            } else {
                player?.replaceCurrentItem(with: viewModel.playerItem)
            }
            player?.play()
            playerDelegate?.playerDidStartPlayback()
        }
    }
}
