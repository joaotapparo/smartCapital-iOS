import SwiftUI

@main
struct SmartCapitalApp: App {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

    var body: some Scene {
        WindowGroup {
            if hasCompletedOnboarding {
                LoginView()
            } else {
                UserInterestView {
                    hasCompletedOnboarding = true
                }
            }
        }
    }
}
