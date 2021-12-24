import SwiftUI
import StandartLib

struct FoodDataSearchScreen: View {
    @ObservedObject var vmConnector: FoodDataSearchViewModelConnector
    
    var body: some View {
        NavigationView {
            List(vmConnector.viewModel.state.rows.indexed(), id: \.index.self) { index, row in
                RowView(data: row).onAppear {
                    print(index)
                }
            }
            .listStyle(.insetGrouped)
            .searchable(text: vmConnector.bind(\.query, { .search($0) }))
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
        FoodDataSearchScreen(vmConnector: FoodDataSearchViewModelConnector(viewModel: FoodDataSearchViewModelPreview()))
    }
}

private final class FoodDataSearchViewModelPreview: FoodDataSearchViewModel {
    
    init() {
        let state = FoodDataSearchViewModelDefault.State(
            rows: [
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
            ],
            query: "apple"
        )
        super.init(initialState: state)
    }
}
