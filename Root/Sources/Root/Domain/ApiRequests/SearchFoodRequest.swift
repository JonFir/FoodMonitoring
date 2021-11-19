import Foundation

struct Errr: Error {
    
}

func searchFoodRequest(
    query: String,
    pageNumber: Int
) async throws -> SearchFoodResponse {
    var components = URL(string: "https://api.nal.usda.gov/fdc/v1")
        .flatMap { $0.appendingPathComponent("/foods/search") }
        .flatMap(URLComponents.init(url:))
    
    components?.queryItems = [
        "query": query,
        "pageSize": 50,
        "pageNumber": pageNumber,
        "api_key": ProcessInfo.processInfo.environment["api_key"]!,
    ].compactMap(URLQueryItem.init(key:value:))
    
    guard var request = components?.url.map(URLRequest.init) else { throw Errr() }
    let (data, _) = try! await URLSession.shared.data(for: request)
    return try JSONDecoder().decode(SearchFoodResponse.self, from: data)
}


extension URLComponents {
    
    init?(url: URL) {
        self.init(url: url, resolvingAgainstBaseURL: true)
    }
    
}


extension URLQueryItem {
    init(key: String, value: Any) {
        self.init(name: key, value: String(describing: value))
    }
}


extension URLRequest {
    
    init(_ url: URL) {
        self.init(url: url)
    }
}
