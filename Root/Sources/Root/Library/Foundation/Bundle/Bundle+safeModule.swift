import SwiftUIPreviewLib
import Foundation
import UIKit

extension Foundation.Bundle {
    
    static var safeModule: Bundle = Bundle.safeModuleForPreview(name: "Root_Root") { Bundle.module }
    
}
