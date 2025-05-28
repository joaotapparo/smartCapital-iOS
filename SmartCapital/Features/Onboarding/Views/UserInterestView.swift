import SwiftUI

/// Screen where the user selects financial categories of interest.
struct UserInterestView: View {
    @StateObject private var viewModel = UserProfileViewModel()
    var onFinished: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Tell us what you're interested in")
                .font(.title2.bold())

            Text("We'll personalize the news and alerts based on your preferences.")
                .font(.subheadline)
                .foregroundColor(.secondary)

            FlexibleTagGrid(items: NewsCategory.allCases, selected: viewModel.selectedCategories) { category in
                viewModel.toggleCategory(category)
            }

            Spacer()

            Button("Continue") {
                Task {
                    await viewModel.saveProfile()
                    onFinished()
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.selectedCategories.isEmpty)
        }
        .padding()
        .navigationTitle("Your Interests")
    }
}
