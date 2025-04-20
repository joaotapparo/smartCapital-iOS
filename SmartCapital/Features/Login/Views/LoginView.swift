import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var shouldNavigate = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Bem-vindo de volta! 👋")
                    .font(.title)
                    .bold()

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                SecureField("Senha", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                PrimaryButton(title: "Entrar") {
                    shouldNavigate = true
                }
            }
            .padding()

            .navigationDestination(isPresented: $shouldNavigate) {
                HomeView()
            }
        }
    }
}

#Preview {
    LoginView()
}
