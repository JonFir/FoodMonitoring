import Foundation

public extension Bundle {
    
    var bundleForLocale: Bundle {
        guard isPreviewMode else { return self }
        
        let path = self.path(forResource: previewLocale, ofType: "lproj") ?? ""
        return Bundle(path: path) ?? self
    }
    
}
