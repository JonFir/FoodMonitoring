import Foundation

public extension URLComponents {
    
    init?(url: URL) {
        self.init(url: url, resolvingAgainstBaseURL: true)
    }
    
}

func componentsFactory(rootUrl: String, path: String) throws -> URLComponents {
    let url = try urlFactory(rootUrl: rootUrl, path: path)
    return try URLComponents(url: url).value(or: NetworkError.invalidUrl)
}
