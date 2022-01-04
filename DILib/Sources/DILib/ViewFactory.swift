import Swinject
import SwiftUI

public protocol ViewFactory {
    func view(forKey key: ViewKey) -> AnyView?
    func view<A>(forKey key: ViewKey, withArgument argument: A) -> AnyView?
}

class ResolverViewFactoryDecorator: ViewFactory {
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

class EmptyViewFactory: ViewFactory {
    func view(forKey key: ViewKey) -> AnyView? {
        nil
    }
    
    func view<A>(forKey key: ViewKey, withArgument argument: A) -> AnyView? {
        nil
    }
}

public struct ViewKey {
    let name: String
    
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
