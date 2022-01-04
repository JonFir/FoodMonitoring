import Swinject
import SwiftUI
import FoodAPI
import MVVMLib
import DILib
import SwiftUILib

public class Assembly: Swinject.Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.registerView(MainScreen.self) { resolver in
            MainScreen { resolver.resolveView(SearchFoodScreen.self)! }.eraseToAnyView()
        }

        container.registerView(SearchFoodScreen.self) { resolver in
            SearchFoodScreen {
                resolver.resolveView(FoodDataSearchScreen.self)!
            }.eraseToAnyView()
        }

        container.register(FoodDataSearchViewModel.self) { resolver in
            FoodDataSearchViewModelDefault(
                searchFoodRequest: resolver.resolve(SearchFoodRequest.self)!,
                initialState: FoodDataSearchViewModelState()
            )
        }

        container.registerView(FoodDataSearchScreen.self) { resolver in
            let connector = ViewModelConnector(viewModel: resolver.resolve(FoodDataSearchViewModel.self)!)
            return FoodDataSearchScreen().environmentObject(connector).eraseToAnyView()
        }
        
    }
    
}
