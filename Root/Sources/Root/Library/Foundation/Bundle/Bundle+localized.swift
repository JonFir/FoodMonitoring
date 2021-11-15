import Foundation
import SwiftUIPreviewLib

extension Foundation.Bundle {
    
    func localized(_ key: String, _ table: String?) -> String {
        return bundleForLocale.localizedString(forKey: key, value: nil, table: table)
    }
}
