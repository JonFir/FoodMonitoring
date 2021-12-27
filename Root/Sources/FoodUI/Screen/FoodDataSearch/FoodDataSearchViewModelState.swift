import Foundation
import FoodAPI
import StandartLib

struct FoodDataSearchViewModelState: CopyMixin {
    var rows = [Row]()
    var query = ""
    var currentPage = 0
    var maxPage = 1
    
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
