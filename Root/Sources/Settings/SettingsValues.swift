import Foundation
import StandartLib

public typealias SettingsForKey = (_ key: SettingsKey) throws -> String

internal let settingsForKey: SettingsForKey = { key in
    if let value = userDefaultSetting(forKey: key) {
        return value
    } else if let value = environmentSetting(forKey: key) {
        return value
    } else if let value = configSetting(forKey: key) {
        return value
    } else {
        throw SettingsError.settingsNotFound(key)
    }
}

private func environmentSetting(forKey key: SettingsKey) -> String? {
    let value = ProcessInfo.processInfo.environment[key.rawValue]
    return value.isNotEmpty ? value : nil
}

private func userDefaultSetting(forKey key: SettingsKey) -> String? {
    let value = UserDefaults.standard.string(forKey: key.rawValue)
    return value.isNotEmpty ? value : nil
}

private func configSetting(forKey key: SettingsKey) -> String? {
    let value = Bundle.main.object(forInfoDictionaryKey: key.rawValue) as? String
    return value.isNotEmpty ? value : nil
}
