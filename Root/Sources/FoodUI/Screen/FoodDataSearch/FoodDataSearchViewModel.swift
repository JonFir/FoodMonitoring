import SwiftUI
import Combine
import FoodAPI

protocol FoodDataSearchViewModel: ObservableObject {
    var rows: [RowConfiguration] { get }
    var query: String { get set }
}

final class FoodDataSearchViewModelDefault: FoodDataSearchViewModel {
    private let searchFoodRequest: SearchFoodRequest
    private var cancellable = Set<AnyCancellable>()
    
    @Published var rows = [RowConfiguration]()
    @Published var query = ""
    private var currentPage = 0
    private var maxPage = Int.max
    
    
    init(
        searchFoodRequest: SearchFoodRequest
    ) {
        self.searchFoodRequest = searchFoodRequest
        $query.sink(receiveValue: search).store(in: &cancellable)
    }

    private func search(query: String) {
        Task {
            do {
                let result = try await searchFoodRequest.run(
                    query: query,
                    pageNumber: 0
                )
                await set(food: result.foods.map { $0.asRowData() })
            } catch {
                print(error)
            }
        }
    }
    
    @MainActor
    private func set(food: [RowConfiguration]) {
        rows = food
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
