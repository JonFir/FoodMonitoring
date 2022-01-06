import SwiftUI
import StandartLib
import MVVMLib
import Localization
import SwiftUIPreviewLib

struct FoodDataSearchScreen: View {
    @EnvironmentObject var vmConnector: ViewModelConnector<FoodDataSearchViewModel>
    
    var body: some View {
        NavigationView {
            Group {
                switch vmConnector.state.variant {
                case .rows: ListView()
                case .empty: Text(L10n.foodDataSearchScreenEmptyResultLabel)
                case .enterQuery: Text(L10n.foodDataSearchScreenStartSearchHint)
                case .loading: ProgressView()
                case .error: Text(vmConnector.state.error)
                }
            }
            .searchable(text: vmConnector.bind(\.query, { .search($0) }))
            .navigationTitle(L10n.foodDataSearchScreenTitle)
        }
    }
}

private struct ListView: View {
    @EnvironmentObject var vmConnector: ViewModelConnector<FoodDataSearchViewModel>
    
    var body: some View {
        List(vmConnector.state.rows.indexed(), id: \.index.self) { index, row in
            RowView(data: row).onAppear {
                vmConnector.dispatch(.itemShowed(index))
            }
        }
        .listStyle(.insetGrouped)
    }
}

private struct RowView: View {
    let data: FoodDataSearchViewModelState.Row
    
    var body: some View {
        Section(header: Text(data.name)) {
            NavigationLink {
                Text("sd")
            } label: {
                VStack {
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
                    if !data.brand.isEmpty {
                        HStack {
                            Text("Бренд:").font(.caption)
                            Spacer()
                            Text(data.brand)
                        }
                    }
                }.lineLimit(1)
            }
        }
    }
}

struct FoodDataSearchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDataSearchScreen()
            .environmentObject(ViewModelConnector<FoodDataSearchViewModel>(viewModel: FoodDataSearchViewModelPreview()))
            .modifier(PreviewLocaleModifier("en"))
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
            query: "apple",
            isPageLoadingInProgress: false,
            error: ""
        )
        super.init(initialState: state)
    }
}
