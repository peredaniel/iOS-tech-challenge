import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        guard let navigationController = window?.rootViewController as? UINavigationController,
            let homeViewController = navigationController.viewControllers.first as? HomeViewController else {
            fatalError("The initial view controller should be set to a HomeViewController embedded into a UINavigationController!")
        }
        guard let configuration = AppConfiguration.init(environment: .production) else {
            fatalError("The app can not run without the proper configuration parameters!")
        }
        let searchService = SearchService(baseUrl: configuration.baseUrl)
        homeViewController.viewModel = HomeViewModel(repository: SearchRepository(service: searchService))
        return true
    }
}
