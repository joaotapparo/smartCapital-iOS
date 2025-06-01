import Foundation

struct Recommendation: Identifiable {
    let id = UUID()
    let content: String
    
    var title: String {
        let sections = content.components(separatedBy: "\n\n")
        if let firstSection = sections.first,
           firstSection.starts(with: "##") {
            return firstSection.replacingOccurrences(of: "##", with: "").trimmingCharacters(in: .whitespaces)
        }
        return "Recomendação Personalizada"
    }
    
    var summary: String {
        let sections = content.components(separatedBy: "\n\n")
        if sections.count > 1 {
            return sections[1].replacingOccurrences(of: "**", with: "").trimmingCharacters(in: .whitespaces)
        }
        return ""
    }
}
