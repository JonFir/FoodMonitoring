import Foundation
import Swinject
import Settings

public class Assembly: Swinject.Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        
        container.register(SearchFoodRequest.self) {
            SearchFoodRequestDefault(
                session: $0.resolve(URLSession.self)!,
                settings: $0.resolve(SettingsForKey.self)!
            )
        }
        
    }
    
}
