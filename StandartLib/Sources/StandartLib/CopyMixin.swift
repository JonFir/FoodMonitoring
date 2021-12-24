public protocol CopyMixin {
    typealias Transformer = (_ object: inout Self) throws -> Void
    
    func copy(transformer: Transformer) rethrows -> Self
}

public extension CopyMixin {
    
    func copy(transformer: Transformer) rethrows -> Self {
        var copy = self
        try transformer(&copy)
        return copy
    }
    
}
