import SwiftUI
import StandartLib
import MVVMLib
import Localization

struct FoodDataSearchScreen: View {
    @EnvironmentObject var vmConnector: ViewModelConnector<FoodDataSearchViewModel>
    
    var body: some View {
        NavigationView {
            List(vmConnector.state.rows.indexed(), id: \.index.self) { index, row in
                RowView(data: row).onAppear {
                    vmConnector.dispatch(.itemShowed(index))
                }
            }
            .listStyle(.insetGrouped)
            .searchable(text: vmConnector.bind(\.query, { .search($0) }))
            .navigationTitle(L10n.foodDataSearchScreenTitle)
        }
    }
}

private struct RowView: View {
    let data: FoodDataSearchViewModelState.Row
    
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
        FoodDataSearchScreen().environmentObject(ViewModelConnector(viewModel: FoodDataSearchViewModelPreview()))
    }
}

private final class FoodDataSearchViewModelPreview: FoodDataSearchViewModel {
    
    init() {
        let state = FoodDataSearchViewModelState(
            rows: [
                FoodDataSearchViewModelState.Row(
                    id: 0,
                    name: "apple",
                    brand: "Apple inc",
                    ingredients: "ingredients",
                    category: "category",
                    calories: "138"
                ),
                FoodDataSearchViewModelState.Row(
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
