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

public protocol ViewFactory {
    func view(forKey key: ViewKey) -> AnyView?
}

private class ResolverViewFactoryDecorator: ViewFactory {
    let resolver: Resolver
    
    init(resolver: Resolver) {
        self.resolver = resolver
    }
    
    func view(forKey key: ViewKey) -> AnyView? {
        resolver.resolveView(key)
    }
    
    func view<A>(forKey key: ViewKey, withArgument argument: A) -> AnyView? {
        resolver.resolveView(key, argument)
    }
}

private class EmptyViewFactory: ViewFactory {
    func view(forKey key: ViewKey) -> AnyView? {
        nil
    }
}

public struct ViewKey {
    fileprivate let name: String
    
    public init<V: View>(_ type: V.Type) {
        name = String(describing: type)
    }
}


private struct ViewFactoryKey: EnvironmentKey {
    static let defaultValue: ViewFactory = EmptyViewFactory()
}

public extension EnvironmentValues {
  var viewFactory: ViewFactory {
    get { self[ViewFactoryKey.self] }
    set { self[ViewFactoryKey.self] = newValue }
  }
}
