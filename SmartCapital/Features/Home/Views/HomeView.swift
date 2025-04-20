import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("🏠 Página Inicial")
                .font(.largeTitle)
                .bold()
                .padding()
            
            Text("Você está logado com sucesso!")
        }
    }
}

#Preview {
    HomeView()
}
