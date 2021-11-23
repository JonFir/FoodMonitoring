import Foundation

public struct Food: Codable {
    public let fdcId: Int
    public let dataType: String?
    public let description: String?
//    let foodCode: Any?
    public let publicationDate: String?
    public let scientificName: String?
    public let brandOwner: String?
    public let ingredients: String?
//    let ndbNumber: Any?
    public let lowercaseDescription: String?
    public let foodCategory: String?
    public let allHighlightFields: String?
    public let score: Double?
    public let foodNutrients: [FoodNutrient]?
}
