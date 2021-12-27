import SwiftUI
import Combine
import FoodAPI
import MVVMLib

typealias FoodDataSearchViewModel = ViewModelAbstract<FoodDataSearchViewModelState, FoodDataSearchViewModelEvent>

final class FoodDataSearchViewModelDefault: FoodDataSearchViewModel {
    private let searchFoodRequest: SearchFoodRequest
    private var nextPageRequest: AnyCancellable?
    private let searchInput = PassthroughSubject<Void, Never>()
    
    init(
        searchFoodRequest: SearchFoodRequest,
        initialState state: State
    ) {
        self.searchFoodRequest = searchFoodRequest
        super.init(initialState: state)
        searchInput
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .sink { [weak self] in
                self?.eventPublisher.send(.requestNextPage)
            }
            .store(in: &cancellable)
    }
    
    override
    func on(event: Event) -> State? {
        switch event {
        case .search(let query):
            return onSearch(query: query)
        case .newResultReceived(let result):
            return onNewResultReceived(result: result)
        case .requestNextPage:
            return onRequestNextPage()
        case .itemShowed(let index):
            onItemShowed(index: index)
            return nil
        }
    }
    
    override
    func on(error: Error) -> State? {
        print(error)
        return nil
    }
    
}

private extension FoodDataSearchViewModelDefault {
    
    func onRequestNextPage() -> State? {
        guard !state.isPageLoadingInProgress else { return nil }
        nextPageRequest?.cancel()
        nextPageRequest = searchFoodRequest
            .run(query: state.query, pageNumber: state.currentPage + 1)
            .map { Event.newResultReceived($0) }
            .resend(toWeak: eventPublisher)
        return state.copy { $0.isPageLoadingInProgress = true }
    }
    
    func onSearch(query: String) -> State {
        searchInput.send()
        return state.copy {
            $0.rows = []
            $0.query = query
            $0.isPageLoadingInProgress = false
        }
    }
    
    func onNewResultReceived(result: SearchFoodResponse) -> State {
        state.copy {
            $0.rows += result.foods.map(FoodDataSearchViewModelState.Row.init(food:))
            $0.currentPage = result.currentPage
            $0.maxPage = result.totalPages
            $0.isPageLoadingInProgress = false
        }
    }
    
    func onItemShowed(index: Int) {
        guard state.rows.count - 5 < index else { return }
        eventPublisher.send(.requestNextPage)
    }
    
}

extension Publisher {
    func resend<P: PassthroughSubject<Output, Failure>>(toWeak subject: P) -> AnyCancellable {
        return sink { [weak subject] completion in
            guard case .failure = completion else { return }
            subject?.send(completion: completion)
        } receiveValue: { [weak subject] output in
            subject?.send(output)
        }
    }
}
