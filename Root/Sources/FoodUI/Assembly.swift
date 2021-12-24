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
                AnyView(resolver.resolve(FoodDataSearchScreen.self)!)
            }
        }
        
        container.register(FoodDataSearchViewModel.self) { resolver in
            FoodDataSearchViewModelDefault(
                searchFoodRequest: resolver.resolve(SearchFoodRequest.self)!,
                initialState: FoodDataSearchViewModel.State()
            )
        }
        
        container.register(FoodDataSearchScreen.self) { resolver in
            FoodDataSearchScreen(
                vmConnector: FoodDataSearchViewModelConnector(
                    viewModel: resolver.resolve(FoodDataSearchViewModel.self)!
                )
            )
        }
        
        
    }
    
}
