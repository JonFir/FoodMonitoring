import SwiftUI

/// An modifier for set global locale in preview model
/// Should be used only in PreviewProvider
public struct PreviewLocaleModifier: ViewModifier {
    
    public init (_ locale: String) {
        assert(isPreviewMode, "should be use only on PreviewProvider")
        previewLocale = locale
    }
    
    public func body(content: Content) -> some View {
        content
    }
}
