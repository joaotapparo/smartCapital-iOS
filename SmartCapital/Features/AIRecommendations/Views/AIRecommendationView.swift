import SwiftUI

struct AIRecommendationView: View {
    @StateObject var viewModel = AIRecommendationsViewModel()
    @State private var isExpanded = false
    let interests: [String]
    let headlines: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Recomendação AI")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Análise personalizada baseada no seu perfil")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                Spacer()
                Image(systemName: "brain.head.profile")
                    .font(.title)
                    .foregroundColor(.blue)
            }
            .padding()
            .background(Color(UIColor.systemBackground))
            
            // Content
            ScrollView {
                if viewModel.isLoading {
                    loadingView
                } else if let recommendation = viewModel.recommendation {
                    VStack(alignment: .leading, spacing: 16) {
                        // Versão resumida
                        if !isExpanded {
                            summaryContent(recommendation)
                        }
                        // Versão detalhada
                        if isExpanded {
                            recommendationContent(recommendation.content)
                        }
                        
                        // Botão expandir/recolher
                        Button(action: {
                            withAnimation {
                                isExpanded.toggle()
                            }
                        }) {
                            HStack {
                                Text(isExpanded ? "Ver menos" : "Ver análise completa")
                                Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                            }
                            .font(.subheadline)
                            .foregroundColor(.blue)
                        }
                        .padding(.top, 8)
                    }
                    .padding()
                    .background(Color(UIColor.systemBackground))
                }
            }
            
            // Footer with refresh button
            HStack {
                Button(action: {
                    Task {
                        await viewModel.fetchRecommendation(from: interests, and: headlines)
                    }
                }) {
                    HStack {
                        Image(systemName: "arrow.clockwise")
                        Text("Atualizar análise")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12)
                }
            }
            .padding()
            .background(Color(UIColor.systemBackground))
        }
        .background(Color(UIColor.systemGroupedBackground))
        .cornerRadius(16)
        .shadow(radius: 5)
        .padding()
        .onAppear {
            Task {
                await viewModel.fetchRecommendation(from: interests, and: headlines)
            }
        }
    }
    
    private var loadingView: some View {
        VStack(spacing: 16) {
            ProgressView()
                .scaleEffect(1.5)
            Text("Analisando mercado...")
                .font(.headline)
            Text("Processando dados e gerando recomendações personalizadas")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .padding()
    }
    
    private func summaryContent(_ recommendation: Recommendation) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            // Título principal
            Text(recommendation.title)
                .font(.headline)
                .foregroundColor(.primary)
            
            // Resumo
            Text(recommendation.summary)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)
            
            // Tags de interesse
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    ForEach(interests, id: \.self) { interest in
                        Text(interest)
                            .font(.caption)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .cornerRadius(20)
                    }
                }
            }
        }
    }
    
    private func recommendationContent(_ content: String) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            // Parse and format markdown sections
            ForEach(parseMarkdownSections(content), id: \.self) { section in
                if section.starts(with: "##") {
                    Text(section.replacingOccurrences(of: "##", with: "").trimmingCharacters(in: .whitespaces))
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.top, 8)
                } else if section.starts(with: "**") {
                    Text(section.replacingOccurrences(of: "**", with: ""))
                        .font(.headline)
                        .foregroundColor(.primary)
                } else if section.starts(with: "*") {
                    HStack(alignment: .top, spacing: 8) {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 6, height: 6)
                            .padding(.top, 8)
                        Text(section.replacingOccurrences(of: "*", with: "").trimmingCharacters(in: .whitespaces))
                            .font(.body)
                    }
                } else {
                    Text(section)
                        .font(.body)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
    
    private func parseMarkdownSections(_ text: String) -> [String] {
        return text.components(separatedBy: "\n\n")
            .filter { !$0.isEmpty }
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
    }
}

#Preview {
    AIRecommendationView(
        interests: ["Varejo", "Economia", "Tecnologia"],
        headlines: ["Exemplo de manchete 1", "Exemplo de manchete 2"]
    )
}
