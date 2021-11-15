import Foundation

public extension Bundle {
    
    /// in preview mode a bundle for selected with PreviewLocaleModifier global locale
    /// in over mode will return self
    var bundleForLocale: Bundle {
        guard isPreviewMode else { return self }
        
        let path = self.path(forResource: previewLocale, ofType: "lproj") ?? ""
        return Bundle(path: path) ?? self
    }
    
}
