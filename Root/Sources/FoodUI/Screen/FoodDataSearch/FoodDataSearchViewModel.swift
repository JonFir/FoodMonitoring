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
    func makeState(fromEvent event: Event) -> State {
        switch event {
        case .search(let query):
            return onSearch(query: query)
        case .newResultReceived(let food):
            return onNewResultReceived(food: food)
        }
    }
    
}

private extension FoodDataSearchViewModelDefault {
    
    private func onSearch(query: String) -> State {
        searchFoodRequest.run(query: query, pageNumber: 0)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] result in
                self?.dispatch(.newResultReceived(result.foods.map(FoodDataSearchViewModelState.Row.init(food:))))
            }.store(in: &cancellable)
        return state.copy { $0.query = query }
    }
    
    private func onNewResultReceived(food: [State.Row]) -> State {
        state.copy { $0.rows = food }
    }
    
}
