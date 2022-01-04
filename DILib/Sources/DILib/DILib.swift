import Swinject
import SwiftUI

public extension Container {
    func registerView(_ key: ViewKey, factory: @escaping (Resolver) -> AnyView) {
        register(AnyView.self, name: key.name) { resolver in
            factory(resolver)
        }
    }
}

public extension Resolver {
    func resolveView(_ key: ViewKey) -> AnyView? {
        return resolve(AnyView.self, name: key.name)
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
