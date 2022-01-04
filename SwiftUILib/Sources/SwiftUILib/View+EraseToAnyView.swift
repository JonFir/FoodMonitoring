import SwiftUI

public extension View {
    func eraseToAnyView() -> AnyView {
        AnyView(erasing: self)
    }
}
