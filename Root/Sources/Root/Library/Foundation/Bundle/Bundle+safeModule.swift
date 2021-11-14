import SwiftUIPreviewLib
import Foundation

extension Foundation.Bundle {
    
    static var safeModule: Bundle = Bundle.safeModuleForPreview(name: "Root_Root") { Bundle.module }
    
    func localized(_ key: String, _ table: String?) -> String {
        localizedString(forKey: key, value: nil, table: table)
    }

}
