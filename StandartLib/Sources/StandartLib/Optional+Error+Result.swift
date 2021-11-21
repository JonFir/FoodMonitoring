import Foundation

public extension Optional {
    
    func value(or error: Error) throws -> Wrapped {
        switch self {
        case .some(let value): return value
        case .none: throw error
        }
    }
    
}
