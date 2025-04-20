import SwiftUI

struct PrimaryButton: View {
    var title: String
    var backgroundColor: Color = .green
    var textColor: Color = .white
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity)
                .padding()
                .background(backgroundColor)
                .foregroundColor(textColor)
                .cornerRadius(12)
        }
    }
}
