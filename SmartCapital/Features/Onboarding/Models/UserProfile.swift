import Foundation

/// Stores user preferences for filtering content.
struct UserProfile: Codable {
    var user_id: String
    var interests: [NewsCategory]
}
