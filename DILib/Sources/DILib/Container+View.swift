import Swinject
import SwiftUI

public extension Container {
    
    func registerView(_ key: ViewKey, factory: @escaping (Resolver) -> AnyView) {
        register(AnyView.self, name: key.name) { resolver in
            factory(resolver)
        }
    }
    
    func registerView<A>(_ key: ViewKey, factory: @escaping (Resolver, A) -> AnyView) {
        register(AnyView.self, name: key.name) { resolver, argument in
            factory(resolver, argument)
        }
    }
    
}
