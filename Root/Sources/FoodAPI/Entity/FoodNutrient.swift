import Foundation

public struct FoodNutrient: Codable {
    public let nutrientId: Int?
    public let nutrientName: String?
    public let nutrientNumber: String?
    public let value: Double?
    public let unitName: String?
    public let derivationCode: String?
    public let derivationDescription: String?
}
