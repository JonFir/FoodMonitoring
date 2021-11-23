import Foundation

public extension URLComponents {
    
    init?(url: URL) {
        self.init(url: url, resolvingAgainstBaseURL: true)
    }
    
    static func make(rootUrl: String, path: String) throws -> URLComponents {
        let url = try URL.make(rootUrl: rootUrl, path: path)
        return try URLComponents(url: url).value(or: NetworkError.invalidUrl)
    }
    
}
