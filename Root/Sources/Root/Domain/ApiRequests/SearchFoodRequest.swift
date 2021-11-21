import Foundation
import NetworkLib
import StandartLib

func searchFoodRequest(
    query: String,
    pageNumber: Int
) async throws -> SearchFoodResponse {
    var components = URL(string: "https://api.nal.usda.gov/fdc/v1")
        .flatMap { $0.appendingPathComponent("/foods/search") }
        .flatMap(URLComponents.init)
    
    components?.queryItems = [
        "query": query,
        "pageSize": 50,
        "pageNumber": pageNumber,
        "api_key": ProcessInfo.processInfo.environment["api_key"],
    ].compactMap(URLQueryItem.init(key:value:))
    
    let request = try components
        .map(URLRequest.init)
        .value(or: NetworkError.invalidUrl)
    

    let (data, _) = try await URLSession.shared.data(for: request)
    return try JSONDecoder().decode(SearchFoodResponse.self, from: data)
}
