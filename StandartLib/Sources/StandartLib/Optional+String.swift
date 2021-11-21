import Foundation

public extension Optional where Wrapped == String {
    
    var isEmpty: Bool {
        switch self {
        case .none: return true
        case .some(let wrapped): return wrapped.isEmpty
        }
    }
    
    var isNotEmpty: Bool {
        !isEmpty
    }
    
}
