import SwiftUI

/// An ViewModifier that feel all available space and align view in to self
public struct Alignment: ViewModifier {
    
    let alignment: SwiftUI.Alignment
    
    public init (_ alignment: SwiftUI.Alignment) {
        self.alignment = alignment
    }
    
    public func body(content: Content) -> some View {
        HStack() { content }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
    }
}
