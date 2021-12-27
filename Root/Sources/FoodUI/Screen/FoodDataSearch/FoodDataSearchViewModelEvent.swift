import FoodAPI

enum FoodDataSearchViewModelEvent {
    case search(_ query: String)
    case newResultReceived(_ result: SearchFoodResponse)
    case requestNextPage
    case itemShowed(_ index: Int)
}
