import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var goToHome = false
    @State private var goToOnboarding = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Login")
                    .font(.title)
                    .bold()

                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)

                SecureField("Password", text: $viewModel.password)
                    .textFieldStyle(.roundedBorder)

                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                }

                Button("Login") {
                    Task {
                        await viewModel.signIn()
                        if viewModel.isAuthenticated && viewModel.errorMessage == nil {
                            if viewModel.isFirstLogin {
                                goToOnboarding = true
                            } else {
                                goToHome = true
                            }
                        }
                    }
                }
                .buttonStyle(.borderedProminent)

                NavigationLink("Don't have an account? Create one", destination: SignUpView())
                    .font(.footnote)
                    .foregroundColor(.blue)

                // ✅ Navegação automática ao autenticar
                NavigationLink(
                    destination: HomeView(),
                    isActive: $goToHome
                ) {
                    EmptyView()
                }
                .hidden()
                
                NavigationLink(
                    destination: UserInterestView(onFinished: {
                        goToHome = true
                    }),
                    isActive: $goToOnboarding
                ) {
                    EmptyView()
                }
                .hidden()
            }
            .padding()
        }
    }
}
