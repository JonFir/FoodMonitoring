import Foundation
import FoodAPI
import StandartLib

struct FoodDataSearchViewModelState: CopyMixin {
    var rows = [Row]()
    var query = ""
    var currentPage = 0
    var maxPage = 1
    var isPageLoadingInProgress = false
    var error = ""
    var variant: Variant {
        switch (rows.isEmpty, query.isEmpty, isPageLoadingInProgress, error.isEmpty) {
        case (false, _, _, _): return .rows
        case (true, _, true, _): return .loading
        case (true, true, false, true): return .enterQuery
        case (true, false, false, true): return .empty
        case (true, _, false, false): return .error
        }
    }
    
    struct Row: Identifiable, Hashable {
        let id: Int
        let name: String
        let brand: String
        let ingredients: String
        let category: String
        let calories: String
    }
    
    enum Variant {
        case enterQuery
        case loading
        case empty
        case rows
        case error
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
