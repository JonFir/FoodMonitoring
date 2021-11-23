import SwiftUI
import FoodUI

public struct MyApp: App {
    public init() {}
    
    public var body: some Scene {
        WindowGroup {
            assembler.resolver.resolve(MainScreen.self)
        }
    }
}
