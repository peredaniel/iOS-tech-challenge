import AVFoundation

protocol TrackPlayerViewModelType {
    var playerItem: AVPlayerItem { get }
}

class TrackPlayerViewModel {
    private let url: URL

    init(url: URL) {
        self.url = url
    }
}

extension TrackPlayerViewModel: TrackPlayerViewModelType {
    var playerItem: AVPlayerItem {
        return AVPlayerItem(asset: AVURLAsset(url: url, options: nil))
    }
}
