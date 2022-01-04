import Swinject
import SwiftUI

public extension Container {
    func registerView<V: View>(_ view: V.Type, factory: @escaping (Resolver) -> AnyView) {
        let key = String(describing: view)
        register(AnyView.self, name: key) { resolver in
            factory(resolver)
        }
    }
}

public extension Resolver {
    func resolveView<V: View>(_ view: V.Type) -> AnyView? {
        let key = String(describing: view)
        return resolve(AnyView.self, name: key)
    }
}
