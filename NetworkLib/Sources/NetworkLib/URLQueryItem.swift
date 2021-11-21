import Foundation

public extension URLQueryItem {
    
    init(key: String, value: Any) {
        self.init(name: key, value: String(describing: value))
    }
    
}
