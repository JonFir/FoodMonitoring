import Swinject
import Foundation
import Settings
import FoodAPI
import FoodUI
import DILib

let assembler = Assembler([
    Root.Assembly(),
    Settings.Assembly(),
    FoodAPI.Assembly(),
    FoodUI.Assembly(),
])

class Assembly: Swinject.Assembly {
    
    func assemble(container: Container) {
        
        container.register(URLSession.self) { _ in
            URLSession.shared
        }
        
    }
    
}
