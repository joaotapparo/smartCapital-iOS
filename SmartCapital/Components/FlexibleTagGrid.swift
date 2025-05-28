import SwiftUI

/// Reusable grid view for tag selection (used in onboarding).
struct FlexibleTagGrid<Item: Hashable & Identifiable & RawRepresentable>: View where Item.RawValue == String {
    let items: [Item]
    let selected: Set<Item>
    let onSelect: (Item) -> Void

    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100), spacing: 12)], spacing: 12) {
            ForEach(items, id: \.id) { item in
                let isSelected = selected.contains(item)

                Text(item.rawValue) // Use rawValue (String)
                    .font(.subheadline)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
                    .foregroundColor(isSelected ? .white : .primary)
                    .clipShape(Capsule())
                    .onTapGesture {
                        onSelect(item)
                    }
            }
        }
    }
}
