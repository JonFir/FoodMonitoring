import Foundation
import FoodAPI

struct FoodDataSearchViewModelState {
    var rows: [Row]
    var query: String
    var currentPage: Int
    var maxPage: Int
    
    init(
        rows: [Row] = [Row](),
        query: String = "",
        currentPage: Int = 0,
        maxPage: Int = Int.max
    ) {
        self.rows = rows
        self.query = query
        self.currentPage = currentPage
        self.maxPage = maxPage
    }
    
    struct Row: Identifiable, Hashable {
        let id: Int
        let name: String
        let brand: String
        let ingredients: String
        let category: String
        let calories: String
    }
}

extension FoodDataSearchViewModelState.Row {
    init(food: Food) {
        self.id = food.fdcId
        self.name = food.lowercaseDescription ?? ""
        self.brand = food.brandOwner ?? ""
        self.ingredients = food.ingredients ?? ""
        self.category = food.foodCategory ?? ""
        self.calories = food.foodNutrients?
            .filter { $0.nutrientId == 1008 }
            .first?.value.map { "\($0)" } ?? ""
    }
}
