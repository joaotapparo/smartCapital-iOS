import Foundation

/// ViewModel responsible for managing user profile data.
final class UserProfileViewModel: ObservableObject {
    @Published var selectedCategories: Set<NewsCategory> = []


    func toggleCategory(_ category: NewsCategory) {
        if selectedCategories.contains(category) {
            selectedCategories.remove(category)
        } else {
            selectedCategories.insert(category)
        }
    }

    func saveProfile() async {
        guard let user = try? await SupabaseManager.shared.client.auth.session.user else {
            print("❌ Usuário não autenticado")
            return
        }

        let profile = UserProfile(user_id: user.id.uuidString, interests: Array(selectedCategories))
        
        do {
            try await SupabaseManager.shared.client
                .from("user_profiles")
                .upsert(profile, onConflict: "user_id")
                .execute()
            UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
            print("✅ Perfil salvo com sucesso: \(profile.interests.map({ $0.rawValue }))")
        } catch {
            print("❌ Erro ao salvar perfil: \(error.localizedDescription)")
        }
    }
}
