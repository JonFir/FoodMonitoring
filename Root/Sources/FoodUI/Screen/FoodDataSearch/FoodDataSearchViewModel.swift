import SwiftUI
import Combine
import FoodAPI

protocol ViewModel {
    associatedtype State
    associatedtype Event
    
    var state: State { get }
    var stateWillChange: PassthroughSubject<Void, Never> { get }
    func dispatch(_ event: Event)
}

protocol ViewModelConnector: ObservableObject {
    associatedtype VM: ViewModel
    
    var viewModel: VM { get }
    var state: VM.State { get }
    
    func bind<Value>(
        _ get: KeyPath<VM.State, Value>,
        _ eventBuilder: @escaping (Value) -> VM.Event
    ) -> Binding<Value>
    
    func dispatch(_ event: VM.Event)
}

extension ViewModelConnector {
    var state: VM.State { viewModel.state }
    
    func bind<Value>(
        _ get: KeyPath<VM.State, Value>,
        _ eventBuilder: @escaping (Value) -> VM.Event
    ) -> Binding<Value> {
        Binding {
            self.viewModel.state[keyPath: get]
        } set: {
            let event = eventBuilder($0)
            self.dispatch(event)
        }
    }
    
    func dispatch(_ event: VM.Event) {
        viewModel.dispatch(event)
    }
}

class FoodDataSearchViewModel: ViewModel {
    fileprivate(set) var state: State
    let stateWillChange = PassthroughSubject<Void, Never>()
    
    init(initialState state: State) {
        self.state = state
    }
    
    func dispatch(_ event: Event) {
        stateWillChange.send()
    }
    
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

class FoodDataSearchViewModelConnector: ViewModelConnector {
    typealias VM = FoodDataSearchViewModel
    let viewModel: FoodDataSearchViewModel
    var stateObserving: AnyCancellable?
    init(viewModel: FoodDataSearchViewModel) {
        self.viewModel = viewModel
        self.stateObserving = viewModel.stateWillChange.sink { [weak self] _ in
            self?.objectWillChange.send()
        }
    }
}

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
    
    override func dispatch(_ event: Event) {
        switch event {
        case .search(let query):
            onSearch(query: query)
        case .newResultReceived(let food):
            onNewResultReceived(food: food)
        }
        super.dispatch(event)
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
