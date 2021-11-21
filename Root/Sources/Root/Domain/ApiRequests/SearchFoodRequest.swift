import Foundation
import NetworkLib
import StandartLib
import Settings

func searchFoodRequest(
    query: String,
    pageNumber: Int
) async throws -> SearchFoodResponse {
    let path = URL(string: try Settings.setting(forKey: .rootUrl))!.appendingPathComponent("/foods/search")
    var components = URLComponents(url: path)
    
    components?.queryItems = [
        "query": query,
        "pageSize": 50,
        "pageNumber": pageNumber,
        "api_key": try Settings.setting(forKey: .apiKey),
    ].compactMap(URLQueryItem.init(key:value:))
    
    let request = try components
        .map(URLRequest.init)
        .value(or: NetworkError.invalidUrl)
    

    let (data, _) = try await URLSession.shared.data(for: request)
    return try JSONDecoder().decode(SearchFoodResponse.self, from: data)
}
