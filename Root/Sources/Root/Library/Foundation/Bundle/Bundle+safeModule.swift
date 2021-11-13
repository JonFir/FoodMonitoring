import SwiftUIPreviewLib
import Foundation

extension Foundation.Bundle {
    
    static var safeModule: Bundle = Bundle.safeModuleForPreview(name: "Root_Root") { Bundle.module }

}
