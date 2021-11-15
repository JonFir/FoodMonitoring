private var locale = "ru"

/// global locale for correct localization in swift ui preview mode
/// used only on preview mode
var previewLocale: String {
    get {
        assert(isPreviewMode, "should be use only on ViewModifier")
        return locale
    }
    set {
        assert(isPreviewMode, "should be use only on ViewModifier")
        locale = newValue
    }
}
