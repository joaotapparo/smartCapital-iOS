import SwiftUI

/// Home screen displaying summarized financial news to the user.
struct HomeView: View {
    @StateObject private var viewModel = NewsViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    greetingSection

                    if viewModel.isLoading {
                        ProgressView("Loading news...")
                            .padding()
                    } else if let error = viewModel.errorMessage {
                        Text("⚠️ \(error)")
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        AIRecommendationView(
                            interests: ["Varejo", "Economia", "Tecnologia"], // substitua com os interesses reais do usuário
                            headlines: viewModel.dailySummary.map { $0.title }
                        )
                        if !viewModel.dailySummary.isEmpty {
                            SectionView(title: "📰 Daily Summary", items: viewModel.dailySummary)
                        }

                        if !viewModel.criticalAlerts.isEmpty {
                            SectionView(title: "🚨 Critical Alerts", items: viewModel.criticalAlerts)
                        }

                        if !viewModel.recentNews.isEmpty {
                            SectionView(title: "🗞️ Latest News", items: viewModel.recentNews)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("SmartCapital")
        }
    }

    /// Greeting header for the user.
    private var greetingSection: some View {
        HStack {
            Image(systemName: "person.circle.fill")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.blue)
            VStack(alignment: .leading) {
                Text("Welcome back")
                    .font(.headline)
                Text("Here’s today’s financial outlook.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}

/// View component for displaying a list of news in a section.
private struct SectionView: View {
    let title: String
    let items: [NewsItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title2)
                .bold()
            ForEach(items) { news in
                Link(destination: URL(string: news.link)!) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(news.title)
                            .font(.headline)
                            .foregroundColor(.primary)
                        if let summary = news.summary {
                            Text(summary)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Text(news.source)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(8)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(8)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
