import SwiftUI
import Combine
import FoodAPI

protocol ViewModel: ObservableObject {
    associatedtype State
    associatedtype Event
    
    var state: State { get }
    
    func bind<Value>(
        _ get: KeyPath<State, Value>,
        _ eventBuilder: @escaping (Value) -> Event
    ) -> Binding<Value>
    
    func dispatch(_ event: Event)
}

protocol ViewModelBindMixin: ViewModel {}

extension ViewModelBindMixin {
    func bind<Value>(
        _ get: KeyPath<State, Value>,
        _ eventBuilder: @escaping (Value) -> Event
    ) -> Binding<Value> {
        Binding {
            self.state[keyPath: get]
        } set: {
            let event = eventBuilder($0)
            self.dispatch(event)
        }
    }
}

protocol ViewModelDispatchStubMixin: ViewModelBindMixin {}

extension ViewModelDispatchStubMixin {
    
    func dispatch(_ event: FoodDataSearchViewModelDefault.Event) {}
}

protocol FoodDataSearchViewModel: ViewModel where
State == FoodDataSearchViewModelDefault.State,
Event == FoodDataSearchViewModelDefault.Event {
}

final class FoodDataSearchViewModelDefault: FoodDataSearchViewModel, ViewModelBindMixin {
    private let searchFoodRequest: SearchFoodRequest
    private var cancellable = Set<AnyCancellable>()
    private(set) var state = State()
    
    init(
        searchFoodRequest: SearchFoodRequest
    ) {
        self.searchFoodRequest = searchFoodRequest
    }
    
    func dispatch(_ event: Event) {
        switch event {
        case .search(let query):
            onSearch(query: query)
        case .newResultReceived(let food):
            onNewResultReceived(food: food)
        }
        objectWillChange.send()
    }
    
    private func onSearch(query: String) {
        state.query = query
        searchFoodRequest.run(query: query, pageNumber: 0)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] result in
                self?.dispatch(.newResultReceived(result.foods.map { $0.asRowData() }))
            }.store(in: &cancellable)
    }
    
    private func onNewResultReceived(food: [RowConfiguration]) {
        state.rows = food
    }
    
}

extension FoodDataSearchViewModelDefault {
    
    struct State {
        fileprivate(set) var rows: [RowConfiguration]
        fileprivate(set) var query: String
        fileprivate var currentPage: Int
        fileprivate var maxPage: Int
        
        init(
            rows: [RowConfiguration] = [RowConfiguration](),
            query: String = "",
            currentPage: Int = 0,
            maxPage: Int = Int.max
        ) {
            self.rows = rows
            self.query = query
            self.currentPage = currentPage
            self.maxPage = maxPage
        }
    }
    
    enum Event {
        case search(_ query: String)
        case newResultReceived(_ food: [RowConfiguration])
    }
}

struct RowConfiguration: Identifiable, Hashable {
    let id: Int
    let name: String
    let brand: String
    let ingredients: String
    let category: String
    let calories: String
}

private extension Food {
    func asRowData() -> RowConfiguration {
        let calories = foodNutrients?
            .filter { $0.nutrientId == 1008 }
            .first?.value.map { "\($0)" }
        ?? ""
        return RowConfiguration(
            id: fdcId,
            name: lowercaseDescription ?? "",
            brand: brandOwner ?? "",
            ingredients: ingredients ?? "",
            category: foodCategory ?? "",
            calories: calories
        )
    }
}
