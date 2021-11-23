import Foundation

public struct IndexedCollection<Base: RandomAccessCollection>: RandomAccessCollection {
    public typealias Index = Base.Index
    public typealias Element = (index: Index, element: Base.Element)

    fileprivate let base: Base

    public var startIndex: Index { base.startIndex }

    public var endIndex: Index { base.endIndex }

    public func index(after index: Index) -> Index {
        base.index(after: index)
    }

    public func index(before index: Index) -> Index {
        base.index(before: index)
    }

    public func index(_ index: Index, offsetBy distance: Int) -> Index {
        base.index(index, offsetBy: distance)
    }

    public subscript(position: Index) -> Element {
        (index: position, element: base[position])
    }
}

public extension RandomAccessCollection {
    func indexed() -> IndexedCollection<Self> {
        IndexedCollection(base: self)
    }
}
