import Foundation

extension Bundle {
    
    func setting(forKey key: SettingsKey) -> String? {
        object(forInfoDictionaryKey: key.rawValue) as? String
    }
    
}
