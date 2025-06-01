import Foundation

@MainActor
class AIRecommendationsViewModel: ObservableObject {
    @Published var recommendation: Recommendation?
    @Published var isLoading = false

    func fetchRecommendation(from interests: [String], and headlines: [String]) async {
        isLoading = true

        let prompt = """
        Sou um assistente financeiro inteligente. Com base nos interesses: \(interests.joined(separator: ", ")) \
        e nas manchetes do dia: \(headlines.joined(separator: " | ")), \
        gere uma recomendação personalizada para o usuário, clara e objetiva.
        """

        do {
            let result = try await GeminiClient.shared.generateRecommendation(prompt: prompt)
            self.recommendation = Recommendation(content: result)
        } catch {
            print("❌ Erro ao chamar Gemini:", error)
            self.recommendation = Recommendation(content: "Erro ao gerar recomendação.")
        }
        isLoading = false
    }
}
