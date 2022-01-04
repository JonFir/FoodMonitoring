import Swinject
import SwiftUI

public extension Resolver {
    func resolveView(_ key: ViewKey) -> AnyView? {
        return resolve(AnyView.self, name: key.name)
    }
    
    func resolveView<A>(_ key: ViewKey, _ argument: A) -> AnyView? {
        return resolve(AnyView.self, name: key.name, argument: argument)
    }
    
    func makeViewFactory() -> ViewFactory {
        ResolverViewFactoryDecorator(resolver: self)
    }
}
