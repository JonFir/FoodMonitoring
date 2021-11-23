import Foundation

public struct SearchFoodResponse: Codable {
    public let currentPage: Int
    public let totalPages: Int
    public let foods: [Food]
}
