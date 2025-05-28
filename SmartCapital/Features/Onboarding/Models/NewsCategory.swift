import Foundation

/// Represents a financial category that the user can follow.
enum NewsCategory: String, CaseIterable, Identifiable, Codable, Hashable {
    case retail = "Retail"
    case economy = "Economy"
    case agro = "Agribusiness"
    case technology = "Technology"
    case politics = "Politics"
    case taxes = "Taxes"
    case inflation = "Inflation"
    case smallBusiness = "Small Business"

    var id: String { rawValue }
}
