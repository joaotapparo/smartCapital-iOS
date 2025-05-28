import Foundation
import Supabase

@MainActor
class AuthViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isAuthenticated = false
    @Published var isFirstLogin: Bool = false

    func signUp() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let _ = try await SupabaseManager.shared.client.auth.signUp(
                email: email,
                password: password
            )
            errorMessage = nil
        } catch {
            print("❌ SignUp failed: \(error.localizedDescription)")
            errorMessage = formatSupabaseError(error)
        }
    }

    func signIn() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let session = try await SupabaseManager.shared.client.auth.signIn(
                email: email,
                password: password
            )
            print("✅ Login successful: \(session.user.email)")
            errorMessage = nil
            isAuthenticated = true

            let userId = session.user.id

            do {
                let _ = try await SupabaseManager.shared.client
                    .database
                    .from("user_profiles")
                    .select()
                    .eq("id", value: userId)
                    .single()
                    .execute()
                isFirstLogin = false
            } catch {
                print("ℹ️ No profile found — assuming first login.")
                isFirstLogin = true
            }

        } catch {
            print("❌ SignIn failed: \(error.localizedDescription)")
            errorMessage = formatSupabaseError(error)
            isAuthenticated = false
        }
    }

    func signOut() async {
        do {
            try await SupabaseManager.shared.client.auth.signOut()
            errorMessage = nil
        } catch {
            print("❌ SignOut failed: \(error.localizedDescription)")
            errorMessage = formatSupabaseError(error)
        }
    }

    private func formatSupabaseError(_ error: Error) -> String {
        let message = error.localizedDescription.lowercased()

        if message.contains("invalid login credentials") {
            return "Email ou senha incorretos."
        } else if message.contains("email not confirmed") {
            return "Confirme seu e-mail antes de entrar."
        } else if message.contains("user already registered") {
            return "Este e-mail já está cadastrado."
        } else {
            return "Erro: \(error.localizedDescription)"
        }
    }
}
