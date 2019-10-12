import Foundation

struct HttpStubInfo {
    /// The endpoint to the API that is mocked. Only the endpoint is necessary.
    let endpoint: String

    /// The name of the JSON file containing the mocked response.
    /// The filename is case sensitive and must not include the extension (which must be .json).
    /// Also, this JSON file must be included in the UITests target bundle.
    let filename: String

    /// An optional String to provide a detail of the response in case we use a statusCode different than 200.
    /// It will usually refer to the detail of the error provided.
    let responseDetail: String?

    /// An optional String of slash-separated keywords indicating the "route" of the JSON response within the JSON file.
    /// It is intended to group multiple server responses in a single JSON file, instead of having a file per response.
    let route: String?

    /// A mandatory integer representing the status code of the response.
    /// This value can be omitted in the init and will default to 200.
    let statusCode: Int

    /// A mandatory instance of the enum HTTPMethod, which may take values GET, POST or PATCH
    /// (additional values can be added in the future).
    let method: HttpMethod

    init(
        endpoint: String,
        filename: String,
        responseDetail: String? = nil,
        route: String? = nil,
        statusCode: Int = 200,
        method: HttpMethod
    ) {
        self.endpoint = endpoint
        self.filename = filename
        self.route = route
        self.responseDetail = responseDetail
        self.statusCode = statusCode
        self.method = method
    }
}
