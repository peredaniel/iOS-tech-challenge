@testable import ABA_Music
import Foundation

struct MockTrackDetailsViewModel: TrackDetailsViewModelType {
    let artistName: String
    let artworkUrl: URL?
    let previewUrl: URL?
    let releaseDate: String?
    let trackCountry: String
    let trackGenre: String
    let trackName: String
}

extension MockTrackDetailsViewModel {
    static let withoutUrls = MockTrackDetailsViewModel(
        artistName: "A Sound of Thunder",
        artworkUrl: nil,
        previewUrl: nil,
        releaseDate: "June 15, 2018",
        trackCountry: "USA",
        trackGenre: "Classic Hard Rock / Classic Power Metal",
        trackName: "It Was Metal"
    )

    static let withPreviewUrl = MockTrackDetailsViewModel(
        artistName: "A Sound of Thunder",
        artworkUrl: nil,
        previewUrl: URL(string: "https://this-is-an-awesome-mock.com/rock-it"),
        releaseDate: "June 15, 2018",
        trackCountry: "USA",
        trackGenre: "Classic Hard Rock / Classic Power Metal",
        trackName: "It Was Metal"
    )

    static let withArtworkUrl = MockTrackDetailsViewModel(
        artistName: "A Sound of Thunder",
        artworkUrl: URL(string: "https://this-is-an-awesome-mock.com/rock-it"),
        previewUrl: nil,
        releaseDate: "June 15, 2018",
        trackCountry: "USA",
        trackGenre: "Classic Hard Rock / Classic Power Metal",
        trackName: "It Was Metal"
    )

    static let withBothUrls = MockTrackDetailsViewModel(
        artistName: "A Sound of Thunder",
        artworkUrl: URL(string: "https://this-is-an-awesome-mock.com/rock-it"),
        previewUrl: URL(string: "https://this-is-an-awesome-mock.com/rock-it"),
        releaseDate: "June 15, 2018",
        trackCountry: "USA",
        trackGenre: "Classic Hard Rock / Classic Power Metal",
        trackName: "It Was Metal"
    )

    static let withLongStrings = MockTrackDetailsViewModel(
        artistName: "Sufjan Stevens (dude, seriously, you need to learn to summarize your titles!)",
        artworkUrl: nil,
        previewUrl: nil,
        releaseDate: "June 15, 2018",
        trackCountry: "In the middle of nowhere... well, not really, he was born in Michigan, USA",
        trackGenre: "Indie folk, alternative rock, indie rock, indie pop, baroque pop, chamber pop, folk pop, avant-garde folk, lo-fi folk, and electronica",
        trackName: "The Black Hawk War, or, How to Demolish an Entire Civilization and Still Feel Good About Yourself in the Morning, or, We Apologize for the Inconvenience but You’re Going to Have to Leave Now, or, ‘I Have Fought the Big Knives and Will Continue to Fight Them Until They Are Off Our Lands!’"
    )
}
