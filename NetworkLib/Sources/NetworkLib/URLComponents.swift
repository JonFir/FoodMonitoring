import Foundation

public extension URLComponents {
    
    init?(url: URL) {
        self.init(url: url, resolvingAgainstBaseURL: true)
    }
    
}
