import Foundation
import Combine

/// Protocol for classifying whether a news item is a critical alert.
protocol AlertClassifier {
    func isCritical(news: NewsItem) -> Bool
}

/// Keyword-based implementation for critical alert classification.
struct KeywordAlertClassifier: AlertClassifier {
    private let keywords = ["queda", "crise", "recessão", "inflação", "impacto", "alerta", "demissão", "baixa", "hike"]

    func isCritical(news: NewsItem) -> Bool {
        let content = (news.title + " " + (news.summary ?? "")).lowercased()
        return keywords.contains { keyword in content.contains(keyword) }
    }
}

/// ViewModel responsible for fetching and categorizing news data.
final class NewsViewModel: ObservableObject {
    @Published var allNews: [NewsItem] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let classifier: AlertClassifier
    
    init(classifier: AlertClassifier = KeywordAlertClassifier()) {
        self.classifier = classifier
        fetchNews()
    }
    
    /// Fetches news from the SmartCapital API.
    func fetchNews() {
        isLoading = true
        errorMessage = nil
        
        guard let url = URL(string: "https://smartcapitalwebscraping-441880730356.us-central1.run.app/noticias") else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    return
                }
                
                guard let data = data else {
                    self?.errorMessage = "No data received"
                    return
                }
                
                do {
                    // Etapa 1: decodifica a resposta como String bruta (JSON escapado)
                    let escapedJSONString = try JSONDecoder().decode(String.self, from: data)
                    
                    // Etapa 2: transforma essa string JSON escapada em Data válido
                    guard let cleanData = escapedJSONString.data(using: .utf8) else {
                        self?.errorMessage = "Failed to re-encode JSON string"
                        return
                    }
                    
                    // Etapa 3: finalmente decodifica o array de NewsItem
                    let news = try JSONDecoder().decode([NewsItem].self, from: cleanData)
                    self?.allNews = news
                    
                } catch {
                    self?.errorMessage = "Failed to decode news: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
    
    /// Top 3 news items for the daily summary section.
    var dailySummary: [NewsItem] {
        Array(allNews.prefix(3))
    }
    
    /// News items classified as critical alerts.
    var criticalAlerts: [NewsItem] {
        let usedIDs = Set(dailySummary.map { $0.id })
        return allNews
            .filter { !usedIDs.contains($0.id) && classifier.isCritical(news: $0) }
            .prefix(5)
            .map { $0 }
    }
    
    /// All news sorted by date, fallback to title order if needed.
    var recentNews: [NewsItem] {
        let usedIDs = Set(dailySummary.map { $0.id } + criticalAlerts.map { $0.id })
        return allNews
            .filter { !usedIDs.contains($0.id) }
            .prefix(20)
            .map { $0 }
    }
}
