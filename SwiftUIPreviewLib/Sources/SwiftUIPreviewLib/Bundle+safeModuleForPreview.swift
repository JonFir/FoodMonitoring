import Foundation

private class CurrentBundleFinder {}

public extension Bundle {
    
    /// will find bundle in swiftUI preview model
    /// in over modes return defaultBundle
    /// - Parameters:
    ///   - name: name of bundle
    ///   - defaultBundle: Bundle for normal mode
    static func safeModuleForPreview(
        name: String,
        or defaultBundle: () -> Bundle
    ) -> Bundle {
        guard isPreviewMode else {
            return defaultBundle()
        }
        
        let candidates = [
            /* Bundle should be present here when the package is linked into an App. */
            Bundle.main.resourceURL,
            
            /* Bundle should be present here when the package is linked into a framework. */
            Bundle(for: CurrentBundleFinder.self).resourceURL,
            
            /* For command-line tools. */
            Bundle.main.bundleURL,
            
            /* Bundle should be present here when running previews from a different package (this is the path to "…/Debug-iphonesimulator/"). */
            Bundle(for: CurrentBundleFinder.self)
                .resourceURL?
                .deletingLastPathComponent()
                .deletingLastPathComponent()
                .deletingLastPathComponent(),
            
            Bundle(for: CurrentBundleFinder.self)
                .resourceURL?
                .deletingLastPathComponent()
                .deletingLastPathComponent(),
        ]
        
        let bundle = candidates
            .compactMap { $0?.appendingPathComponent(name + ".bundle") }
            .compactMap(Bundle.init(url:))
            .first
        
        guard let bundle = bundle else {
            fatalError("unable to find bundle")
        }
        
        return bundle
    }
    
}
