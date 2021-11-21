import Foundation

public extension URLRequest {
    
    init(_ url: URL) {
        self.init(url: url)
    }
    
    init(components: URLComponents) throws {
        guard let url = components.url else { throw NetworkError.invalidUrl }
        self.init(url)
    }
}
