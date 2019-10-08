import AVFoundation
import UIKit

class PlayerView: UIView {
    var movieURL: URL?
    var player: AVPlayer = AVPlayer()

    init() {
        super.init(frame: .zero)
        setupPlayer()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        player.pause()
    }

    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
    }

    private func setupPlayer() {
        if let layer = layer as? AVPlayerLayer {
            layer.player = player
            layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        }
    }

    func prepare(with movieURL: URL) {
        self.movieURL = movieURL
    }

    func play() {
        guard let movieURL = movieURL else { return }
        if player.currentItem != nil {
            player.seek(to: .zero) { [weak self] _ in
                guard let self = self else { return }
                self.player.play()
            }
        } else {
            let asset = AVURLAsset(url: movieURL, options: nil)
            let playerItem = AVPlayerItem(asset: asset)
            player.replaceCurrentItem(with: playerItem)
            player.play()
        }
    }

    func pause() {
        player.pause()
    }
}
