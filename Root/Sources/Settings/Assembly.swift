import Swinject

public class Assembly: Swinject.Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(SettingsForKey.self) { _ in
           settingsForKey
        }
    }
    
}
