import SwiftUI
import Combine
import FoodAPI
import MVVMLib

typealias FoodDataSearchViewModel = ViewModelAbstract<FoodDataSearchViewModelState, FoodDataSearchViewModelEvent>

final class FoodDataSearchViewModelDefault: FoodDataSearchViewModel {
    private let searchFoodRequest: SearchFoodRequest
    private var cancellable = Set<AnyCancellable>()
    
    init(
        searchFoodRequest: SearchFoodRequest,
        initialState state: State
    ) {
        self.searchFoodRequest = searchFoodRequest
        super.init(initialState: state)
    }
    
    override
    func makeState(fromEvent event: FoodDataSearchViewModelEvent) -> FoodDataSearchViewModelState {
        switch event {
        case .search(let query):
            return onSearch(query: query)
        case .newResultReceived(let food):
            return onNewResultReceived(food: food)
        }
    }
    
}

private extension FoodDataSearchViewModelDefault {
    
    private func onSearch(query: String) -> FoodDataSearchViewModelState {
        searchFoodRequest.run(query: query, pageNumber: 0)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] result in
                self?.dispatch(.newResultReceived(result.foods.map(FoodDataSearchViewModelState.Row.init(food:))))
            }.store(in: &cancellable)
        var state = state
        state.query = query
        return state
    }
    
    private func onNewResultReceived(food: [State.Row]) -> FoodDataSearchViewModelState {
        var state = state
        state.rows = food
        return state
    }
    
}
