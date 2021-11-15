import Foundation
import SwiftUIPreviewLib

extension Foundation.Bundle {
    
    /// SwiftUI preview workaround.
    /// Find correct locale in preview mode
    /// in over modes work like `localizedString`
    func localized(_ key: String, _ table: String?) -> String {
        return bundleForLocale.localizedString(forKey: key, value: nil, table: table)
    }
}
