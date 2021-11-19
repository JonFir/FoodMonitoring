import Foundation

struct SearchFoodResponse: Codable {
    let currentPage: Int
    let totalPages: Int
    let foods: [Food]
}
