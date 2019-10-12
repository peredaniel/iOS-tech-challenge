import Foundation
import Swifter
import os.log

public enum HttpMethod {
    case post
    case get
    case patch
}

final class MockServer {
    enum Constant {
        static let bundleIdentifier = Bundle(for: MockServer.self).bundleIdentifier ?? "com.abaenglish.ABA-MusicUITests"
    }

    private var server = HttpServer()
    private let logger = OSLog(
        subsystem: Constant.bundleIdentifier,
        category: String(describing: MockServer.self)
    )

    func setUp() {
        setupNotFoundResponse()
        do {
            try server.start(8080, forceIPv4: false, priority: .default)
        } catch {
            os_log("Mock server instance couldn't be started.", log: logger, type: .error)
        }
    }

    func tearDown() {
        server.stop()
    }

    func addMockedResponse(_ stub: HttpStubInfo) {
        guard let json = MockServer.jsonData(stub.filename, route: stub.route) else {
            os_log(
                "Failed to parse JSON response in file %{public}@/%{public}@ for endpoint %{public}@",
                log: logger,
                type: .error,
                stub.filename,
                stub.route ?? "",
                stub.endpoint
            )
            return
        }

        let response: ((HttpRequest) -> HttpResponse)
        if let responseBody = try? JSONSerialization.data(withJSONObject: json, options: .sortedKeys) {
            response = { _ in
                .raw(
                    stub.statusCode,
                    stub.responseDetail ?? "OK",
                    ["Content-Type": "application/json;charset=utf-8"],
                    { try $0.write(responseBody) }
                )
            }
        } else {
            response = { _ in .internalServerError }
        }

        switch stub.method {
        case .get : server.GET[stub.endpoint] = response
        case .post: server.POST[stub.endpoint] = response
        case .patch: server.PATCH[stub.endpoint] = response
        }
    }
}

private extension MockServer {
    func setupNotFoundResponse() {
        server.notFoundHandler = { [weak self] (request: HttpRequest) in
            guard let self = self else { return .notFound }
            let notImplemented = "Response not implemented:"
            let method = "* Method: \(request.method)"
            let endpoint = "* Endpoint: \(request.path)"
            let parameters = "* Parameters: \(request.params)"
            let queryParameters = "* Query Parameters: \(request.queryParams)"
            let body = "* Body: \(String(bytes: request.body, encoding: .utf8) ?? "-")"
            let message = [
                notImplemented,
                method,
                endpoint,
                parameters,
                queryParameters,
                body
            ].joined(separator: "\n")
            os_log("%{public}@", log: self.logger, type: .debug, message)
            return .notFound
        }
    }

    static func jsonData(
        _ filename: String,
        route: String?
    ) -> Any? {
        guard let fileUrl = Bundle(for: MockServer.self).url(forResource: filename, withExtension: "json"),
            let data = try? Data(contentsOf: fileUrl, options: .uncached),
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
            var jsonObject = json as? [String: Any] else {
            return nil
        }
        if let route = route {
            let components = route.components(separatedBy: "/")
            for component in components {
                if let subJson = jsonObject[component] as? [String: Any] {
                    jsonObject = subJson
                } else {
                    return nil
                }
            }
        }
        return jsonObject as Any
    }
}
