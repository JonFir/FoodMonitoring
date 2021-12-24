enum FoodDataSearchViewModelEvent {
    case search(_ query: String)
    case newResultReceived(_ food: [FoodDataSearchViewModelState.Row])
}
