enum SearchStub {
    enum Album {
        static var emptyResponse = HttpStubInfo(
            endpoint: "/search?term=&media=musicVideo&entity=musicVideo&attribute=albumTerm&limit=200",
            filename: "SearchResponses",
            route: "emptyResponse",
            method: .get
        )

        static var error = HttpStubInfo(
            endpoint: "/search?term=Trigger+error&media=musicVideo&entity=musicVideo&attribute=albumTerm&limit=200",
            filename: "SearchResponses",
            responseDetail: "Bad request",
            route: "errorResponse",
            statusCode: 400,
            method: .get
        )

        static var rebirth = HttpStubInfo(
            endpoint: "/search?term=Rebirth&media=musicVideo&entity=musicVideo&attribute=albumTerm&limit=200",
            filename: "SearchResponses",
            route: "albumTerm/Rebirth",
            method: .get
        )

        static var jackson = HttpStubInfo(
            endpoint: "/search?term=Jackson&media=musicVideo&entity=musicVideo&attribute=albumTerm&limit=200",
            filename: "SearchResponses",
            route: "albumTerm/Jackson",
            method: .get
        )
    }

    enum Artist {
        static var emptyResponse = HttpStubInfo(
            endpoint: "/search?term=&media=musicVideo&entity=musicVideo&attribute=artistTerm&limit=200",
            filename: "SearchResponses",
            route: "emptyResponse",
            method: .get
        )

        static var error = HttpStubInfo(
            endpoint: "/search?term=Trigger+error&media=musicVideo&entity=musicVideo&attribute=albumTerm&limit=200",
            filename: "SearchResponses",
            responseDetail: "Bad request",
            route: "errorResponse",
            statusCode: 400,
            method: .get
        )

        static var beatles = HttpStubInfo(
            endpoint: "/search?term=Beatles&media=musicVideo&entity=musicVideo&attribute=artistTerm&limit=200",
            filename: "SearchResponses",
            route: "artistTerm/Beatles",
            method: .get
        )

        static var jackson = HttpStubInfo(
            endpoint: "/search?term=Jackson&media=musicVideo&entity=musicVideo&attribute=artistTerm&limit=200",
            filename: "SearchResponses",
            route: "artistTerm/Jackson",
            method: .get
        )
    }

    enum Song {
        static var emptyResponse = HttpStubInfo(
            endpoint: "/search?term=&media=musicVideo&entity=musicVideo&attribute=songTerm&limit=200",
            filename: "SearchResponses",
            route: "emptyResponse",
            method: .get
        )

        static var error = HttpStubInfo(
            endpoint: "/search?term=Trigger+error&media=musicVideo&entity=musicVideo&attribute=albumTerm&limit=200",
            filename: "SearchResponses",
            responseDetail: "Bad request",
            route: "errorResponse",
            statusCode: 400,
            method: .get
        )

        static var jackson = HttpStubInfo(
            endpoint: "/search?term=Jackson&media=musicVideo&entity=musicVideo&attribute=songTerm&limit=200",
            filename: "SearchResponses",
            route: "songTerm/Jackson",
            method: .get
        )

        static var ladyMadonna = HttpStubInfo(
            endpoint: "/search?term=Lady+madonna&media=musicVideo&entity=musicVideo&attribute=songTerm&limit=200",
            filename: "SearchResponses",
            route: "songTerm/Lady Madonna",
            method: .get
        )
    }
}
