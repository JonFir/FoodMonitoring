import SwiftUI
import StandartLib

struct FoodDataSearchScreen<ViewModel: FoodDataSearchViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.rows.indexed(), id: \.index.self) { index, row in
                RowView(data: row).onAppear {
                    print(index)
                }
            }.listStyle(.insetGrouped)
            .searchable(text: $viewModel.query)
            .navigationTitle("Searchable Example")
        }
    }
}

private struct RowView: View {
    let data: RowConfiguration
    
    var body: some View {
        Section(header: Text(data.name)) {
            HStack {
                Text("Калл:").font(.caption)
                Spacer()
                Text(data.calories)
            }
            HStack {
                Text("Категория:").font(.caption)
                Spacer()
                Text(data.category)
            }
            HStack {
                Text("Бренд:").font(.caption)
                Spacer()
                Text(data.brand)
            }
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
