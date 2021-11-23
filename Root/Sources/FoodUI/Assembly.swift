import Swinject
import SwiftUI
import FoodAPI

public class Assembly: Swinject.Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(MainScreen.self) { resolver in
            MainScreen { AnyView(resolver.resolve(SearchFoodScreen.self)!) }
        }
        
        container.register(SearchFoodScreen.self) { resolver in
            SearchFoodScreen {
                AnyView(resolver.resolve(FoodDataSearchScreen<FoodDataSearchViewModelDefault>.self)!)
            }
        }
        
        container.register(FoodDataSearchViewModelDefault.self) { resolver in
            FoodDataSearchViewModelDefault(searchFoodRequest: resolver.resolve(SearchFoodRequest.self)!)
        }
        
        container.register(FoodDataSearchScreen<FoodDataSearchViewModelDefault>.self) { resolver in
            FoodDataSearchScreen<FoodDataSearchViewModelDefault>(
                viewModel: resolver.resolve(FoodDataSearchViewModelDefault.self)!
            )
        }
        
        
    }
    
}
