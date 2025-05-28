import Foundation

/// Represents a news item retrieved from the SmartCapital API.
struct NewsItem: Identifiable, Codable {
    let id: String
    let title: String
    let link: String
    let summary: String?
    let source: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title = "titulo"
        case link
        case summary = "resumo"
        case source = "fonte"
    }
}
