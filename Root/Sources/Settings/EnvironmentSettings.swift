import Foundation

enum Environment {
    
    func setting(forKey key: SettingsKey) -> String? {
        ProcessInfo.processInfo.environment["api_key"]
    }
    
}

