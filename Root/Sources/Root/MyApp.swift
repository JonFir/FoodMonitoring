import SwiftUI
import FoodUI
import Swinject

public struct MyApp: App {
    public init() {}
    
    public var body: some Scene {
        WindowGroup {
            assembler.resolver.resolveView(.main)
        }
    }
}
