import SwiftUI
import Combine
import FoodAPI
import MVVMLib

typealias FoodDataSearchViewModel = ViewModelAbstract<FoodDataSearchViewModelState, FoodDataSearchViewModelEvent>

final class FoodDataSearchViewModelDefault: FoodDataSearchViewModel {
    private let searchFoodRequest: SearchFoodRequest
    private var nextPageRequest: AnyCancellable?
//    private let nextPageStarter = PassthroughSubject<(SearchFoodRequest, String, Int), Error>()
    
    init(
        searchFoodRequest: SearchFoodRequest,
        initialState state: State
    ) {
        self.searchFoodRequest = searchFoodRequest
        super.init(initialState: state)
//        nextPageStarter
//            .debounce(for: 0.2, scheduler: RunLoop.main)
//            .map { params in
//                return params.0.run(query: params.1, pageNumber: params.2)
//            }
//            .switchToLatest()
//            .sink { completion in
//                print(completion)
//            } receiveValue: { [weak self] result in
//                self?.dispatch(.newResultReceived(result: result))
//            }
//            .store(in: &cancellable)
    }
    
    override
    func on(event: Event) -> State? {
        switch event {
        case .search(let query):
            return onSearch(query: query)
        case .newResultReceived(let result):
            return onNewResultReceived(result: result)
        case .requestNextPage:
            onRequestNextPage()
            return nil
        case .itemShowed(let index):
            onItemShowed(index: index)
            return nil
        }
    }
    
}

private extension FoodDataSearchViewModelDefault {
    
    func onRequestNextPage() {
        guard nextPageRequest == nil else { return }
        nextPageRequest = searchFoodRequest.run(query: state.query, pageNumber: state.currentPage + 1)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] result in
                self?.nextPageRequest = nil
                self?.dispatch(.newResultReceived(result))
            }
    }
    
    func onSearch(query: String) -> State {
        nextPageRequest?.cancel()
        nextPageRequest = nil
        dispatch(.requestNextPage)
        return state.copy {
            $0.rows = []
            $0.query = query
        }
    }
    
    func onNewResultReceived(result: SearchFoodResponse) -> State {
        state.copy {
            $0.rows += result.foods.map(FoodDataSearchViewModelState.Row.init(food:))
            $0.currentPage = result.currentPage
            $0.maxPage = result.totalPages
        }
    }
    
    func onItemShowed(index: Int) {
        guard state.rows.count - 5 < index else { return }
        dispatch(.requestNextPage)
    }
    
}
