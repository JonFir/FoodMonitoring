import Foundation
import NetworkLib
import StandartLib
import Settings

func searchFoodRequest(
    session: URLSession,
    settings: SettingsForKey,
    query: String,
    pageNumber: Int
) async throws -> SearchFoodResponse {
    let path = try URL(string: settings(.rootUrl))
        .value(or: NetworkError.invalidUrl)
        .appendingPathComponent("/foods/search")
    
    var components = try URLComponents(url: path).value(or: NetworkError.invalidUrl)
    components.queryItems = [
        "query": query,
        "pageSize": 50,
        "pageNumber": pageNumber,
        "api_key": try settings(.apiKey),
    ].compactMap(URLQueryItem.init(key:value:))
    
    let (data, _) = try await session.data(from: components.url.value(or: NetworkError.invalidUrl))
    return try JSONDecoder().decode(SearchFoodResponse.self, from: data)
}
