import SwiftUI
import Combine

struct RowData: Identifiable {
    let id: Int
    let name: String
    let brand: String
    let ingredients: String
    let category: String
    let calories: String
}

private extension Food {
    func asRowData() -> RowData {
        let calories = foodNutrients?
            .filter { $0.nutrientId == 1008 }
            .first?.value.map { "\($0)" }
        ?? ""
        return RowData(
            id: fdcId,
            name: lowercaseDescription ?? "",
            brand: brandOwner ?? "",
            ingredients: ingredients ?? "",
            category: foodCategory ?? "",
            calories: calories
        )
    }
}

protocol FoodDataSearchViewModel: ObservableObject {
    var rows: [RowData] { get }
    var query: String { get set }
    
    func search(query: String)
}


final class FoodDataSearchViewModelDefault: FoodDataSearchViewModel {
    @Published var rows = [RowData]()
    @Published var query = ""
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        $query.sink(receiveValue: search).store(in: &cancellable)
    }

    func search(query: String) {
        Task {
            do {
                let result = try await searchFoodRequest(query: query, pageNumber: 0)
                await set(food: result.foods.map { $0.asRowData() })
            } catch {
                print(error)
            }
        }
    }
    
    @MainActor
    private func set(food: [RowData]) {
        rows = food
    }

}

final class FoodDataSearchViewModelPreview: FoodDataSearchViewModel {
    @Published var rows = [
        RowData(
            id: 0,
            name: "apple",
            brand: "Apple inc",
            ingredients: "ingredients",
            category: "category",
            calories: "138"
        )
    ]
    @Published var query = "apple"
    
    func search(query: String) {
        
    }

}

struct FoodDataSearchScreenView<ViewModel: FoodDataSearchViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.rows) { row in
                Text(row.name + "1")
                Text(row.brand + "2")
                Text(row.calories + "3")
            }
            .searchable(text: $viewModel.query)
            .navigationTitle("Searchable Example")
        }
    }
}

struct FoodDataSearchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDataSearchScreenView<FoodDataSearchViewModelPreview>(viewModel: FoodDataSearchViewModelPreview())
    }
}
