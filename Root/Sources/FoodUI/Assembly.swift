import Swinject
import SwiftUI
import FoodAPI
import MVVMLib
import DILib
import SwiftUILib

public extension ViewKey {
    static let main = ViewKey(MainScreen.self)
    static let searchFood = ViewKey(SearchFoodScreen.self)
    static let foodDataSearch = ViewKey(FoodDataSearchScreen.self)
}

public class Assembly: Swinject.Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.registerView(.main) { resolver in
            MainScreen()
                .environment(\.viewFactory, resolver.makeViewFactory())
                .eraseToAnyView()
        }

        container.registerView(.searchFood) { resolver in
            SearchFoodScreen()
                .environment(\.viewFactory, resolver.makeViewFactory())
                .eraseToAnyView()
        }

        container.register(FoodDataSearchViewModel.self) { resolver in
            FoodDataSearchViewModelDefault(
                searchFoodRequest: resolver.resolve(SearchFoodRequest.self)!,
                initialState: FoodDataSearchViewModelState()
            )
        }

        container.registerView(.foodDataSearch) { resolver in
            let connector = ViewModelConnector(viewModel: resolver.resolve(FoodDataSearchViewModel.self)!)
            return FoodDataSearchScreen().environmentObject(connector).eraseToAnyView()
        }
        
    }
    
}
