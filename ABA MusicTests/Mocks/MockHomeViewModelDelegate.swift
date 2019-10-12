@testable import ABA_Music
import Foundation

class MockHomeViewModelDelegate: HomeViewModelDelegate {
    var didFailToFetchData: (() -> Void)?

    func viewModelFailedToFetchData(_: HomeViewModelType) {
        didFailToFetchData?()
    }

    func viewModel(
        _: HomeViewModelType,
        didSelectItemWithViewModel _: TrackDetailsViewModelType
    ) {
        return
    }
}
