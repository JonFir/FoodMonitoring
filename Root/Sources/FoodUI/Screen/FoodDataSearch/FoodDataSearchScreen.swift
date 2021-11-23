import SwiftUI

struct FoodDataSearchScreen<ViewModel: FoodDataSearchViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.rows) { row in
                    RowView(data: row)
                }
            }
            .searchable(text: $viewModel.query)
            .navigationTitle("Searchable Example")
        }
    }
}

private struct RowView: View {
    let data: RowConfiguration
    
    var body: some View {
        VStack {
            Text(data.name)
            Text(data.brand)
            Text(data.calories)
        }
    }
}

struct FoodDataSearchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDataSearchScreen<FoodDataSearchViewModelPreview>(viewModel: FoodDataSearchViewModelPreview())
    }
}

private final class FoodDataSearchViewModelPreview: FoodDataSearchViewModel {
    @Published var rows = [
        RowConfiguration(
            id: 0,
            name: "apple",
            brand: "Apple inc",
            ingredients: "ingredients",
            category: "category",
            calories: "138"
        ),
        RowConfiguration(
            id: 0,
            name: "apple",
            brand: "Apple inc",
            ingredients: "ingredients",
            category: "category",
            calories: "138"
        ),
    ]
    @Published var query = "apple"

}
