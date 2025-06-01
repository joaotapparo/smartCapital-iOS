import Foundation

struct GeminiMessage: Codable {
    let text: String
}

struct GeminiRequest: Codable {
    let contents: [GeminiContent]
}

struct GeminiContent: Codable {
    let role: String?
    let parts: [GeminiPart]
}

struct GeminiPart: Codable {
    let text: String
}

struct GeminiResponse: Codable {
    let candidates: [GeminiCandidate]
}

struct GeminiCandidate: Codable {
    let content: GeminiContent
}

struct GeminiErrorResponse: Codable {
    let error: GeminiError
}

struct GeminiError: Codable {
    let message: String
    let status: String
}

class GeminiClient {
    static let shared = GeminiClient()
    private let apiKey: String
    
    private init() {
        guard let key = ProcessInfo.processInfo.environment["GEMINI_API_KEY"], !key.isEmpty else {
            fatalError("❌ GEMINI_API_KEY not set in environment variables.")
        }
        self.apiKey = key
    }
    
    func generateRecommendation(prompt: String) async throws -> String {
        let modelName = "models/gemma-3-4b-it"
        
        let urlString = "https://generativelanguage.googleapis.com/v1beta/\(modelName):generateContent?key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "Gemini", code: 400, userInfo: [NSLocalizedDescriptionKey: "URL inválida"])
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let content = GeminiContent(role: "user", parts: [GeminiPart(text: prompt)])
        let body = GeminiRequest(contents: [content])
        
        request.httpBody = try JSONEncoder().encode(body)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        if let jsonString = String(data: data, encoding: .utf8) {
            print("🟢 Resposta da API Gemini: \(jsonString)")
        }
        
        do {
            let response = try JSONDecoder().decode(GeminiResponse.self, from: data)
            return response.candidates.first?.content.parts.first?.text ?? "Sem resposta"
        } catch {
            if let errorResponse = try? JSONDecoder().decode(GeminiErrorResponse.self, from: data) {
                throw NSError(domain: "Gemini",
                            code: 400,
                            userInfo: [NSLocalizedDescriptionKey: "Erro da API Gemini: \(errorResponse.error.message)"])
            }
            throw error
        }
    }
} 