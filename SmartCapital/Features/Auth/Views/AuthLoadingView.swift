import SwiftUI

struct AuthLoadingView: View {
    var body: some View {
        ProgressView("Checking session...")
            .task {
                if let session = try? await SupabaseManager.shared.client.auth.session {
                    // Usuário autenticado, navegue para a HomeView
                    print("🔐 Sessão ativa: \(session.user.email ?? "sem email")")
                    // Exemplo: mudar uma flag de navegação com @State
                } else {
                    // Sem sessão, navegue para LoginView
                    print("🚪 Sem sessão")
                }
                // Navegar para HomeView ou LoginView dependendo da sessão
            }
            .navigationTitle("Loading")
    }
}
