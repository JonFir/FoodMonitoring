import SwiftUI

public struct PreviewLocaleModifier: ViewModifier {
    
    public init (_ locale: String) {
        assert(isPreviewMode, "should be use only on ViewModifier")
        previewLocale = locale
    }
    
    public func body(content: Content) -> some View {
        content
    }
}
