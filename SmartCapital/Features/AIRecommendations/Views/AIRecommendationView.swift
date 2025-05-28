import SwiftUI

struct AIRecommendationView: View {
    @StateObject var viewModel = AIRecommendationsViewModel()
    let interests: [String]
    let headlines: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("🔍 AI Recommendation")
                .font(.headline)

            if viewModel.isLoading {
                ProgressView("Gerando recomendação...")
            } else if let rec = viewModel.recommendation {
                Text(rec.content)
                    .font(.body)
            }

            Button("Atualizar recomendação") {
                Task {
                    await viewModel.fetchRecommendation(from: interests, and: headlines)
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .onAppear {
            Task {
                await viewModel.fetchRecommendation(from: interests, and: headlines)
            }
        }
    }
}
