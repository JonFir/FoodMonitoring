import Foundation
import NetworkLib
import StandartLib
import Settings
import Combine

public protocol SearchFoodRequest {
    init(
        session: URLSession,
        settings: @escaping SettingsForKey
    )
    
    func run(
        query: String,
        pageNumber: Int
    ) -> AnyPublisher<SearchFoodResponse, Error>
}

class SearchFoodRequestDefault: SearchFoodRequest {
    private let session: URLSession
    private let settings: SettingsForKey
    
    required init(
        session: URLSession,
        settings: @escaping SettingsForKey
    ) {
        self.session = session
        self.settings = settings
    }
    
    func run(
        query: String,
        pageNumber: Int
    ) -> AnyPublisher<SearchFoodResponse, Error> {
        let session = session
        let settings = settings
        return Deferred {
            Just(())
                .setFailureType(to: Error.self)
                .tryMap { _ in
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
                    return try URLRequest(components: components)
                }
                .flatMap { (request: URLRequest) in
                    session.dataTaskPublisher(for: request).mapError { $0 as Error }
                }
                .map { $0.data }
                .decode(type: SearchFoodResponse.self, decoder: JSONDecoder())
        }
        .eraseToAnyPublisher()
    }
    
}
