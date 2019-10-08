import UIKit

class TrackDetailsViewController: UIViewController {
    var playerView: PlayerView!
    var stackView: UIStackView!

    var viewModel: TrackDetailsViewModelType?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let viewModel = viewModel else {
            fatalError("This screen's view model should be provided by the previous screen")
        }
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.distribution = .equalSpacing
        playerView = PlayerView()
        if let url = viewModel.previewUrl {
            playerView.prepare(with: url)
        }
        title = viewModel.trackName

        playerView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        playerView.layer.borderColor = UIColor.blue.cgColor
        playerView.layer.borderWidth = 1
        view.addSubview(playerView)
        view.addSubview(stackView)
        playerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        playerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        playerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        playerView.heightAnchor.constraint(equalTo: playerView.widthAnchor, multiplier: 9 / 16).isActive = true
        stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 10).isActive = true
        stackView.topAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 10).isActive = true
        playerView.backgroundColor = UIColor.black
        addLabel(text: viewModel.artistName, size: 25)
        addLabel(text: viewModel.trackName, size: 15)
        addLabel(text: viewModel.trackGenre, size: 15)
        addLabel(text: viewModel.trackCountry, size: 10)
        if let releaseDate = viewModel.releaseDate {
            addLabel(text: releaseDate, size: 10)
        }
        view.backgroundColor = .lightGray
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        playerView.play()
    }

    func addLabel(text: String, size: CGFloat) {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Helvetica Neue", size: size)
        label.text = text
        label.numberOfLines = 0
        stackView.addArrangedSubview(label)
    }
}
