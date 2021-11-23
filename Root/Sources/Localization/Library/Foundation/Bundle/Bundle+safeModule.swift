import SwiftUIPreviewLib
import Foundation
import UIKit

extension Foundation.Bundle {
    
    /// in swiftUI preview mode will find bundle by name
    /// in normal mode return module bundle
    static var safeModule: Bundle = Bundle.safeModuleForPreview(name: "Root_Localization") { Bundle.module }
    
}
