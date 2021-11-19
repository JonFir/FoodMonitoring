import Foundation

struct Food: Codable {
    let fdcId: Int
    let dataType: String?
    let description: String?
//    let foodCode: Any?
    let publicationDate: String?
    let scientificName: String?
    let brandOwner: String?
    let ingredients: String?
//    let ndbNumber: Any?
    let lowercaseDescription: String?
    let foodCategory: String?
    let allHighlightFields: String?
    let score: Double?
    let foodNutrients: [FoodNutrient]?
    
}
