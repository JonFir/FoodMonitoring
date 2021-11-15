private var locale = "ru"

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
