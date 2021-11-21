import Foundation

public enum SettingsError: Error {
    case settingsNotFound(SettingsKey)
}
