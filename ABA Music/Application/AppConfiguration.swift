import Foundation

enum Environment: String {
    case production
}

struct AppConfiguration: Decodable {
    let baseUrl: String
}

extension AppConfiguration {
    init?(environment: Environment) {
        let configurationFileName = "AppConfiguration_\(environment.rawValue)"
        guard let url = Bundle.main.url(forResource: configurationFileName, withExtension: "json"),
            let data = try? Data(contentsOf: url),
            let configuration = try? JSONDecoder().decode(AppConfiguration.self, from: data) else { return nil }
        self = configuration
    }
}
