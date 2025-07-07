import SwiftUI
struct EmptyStateView: View {
    var body: some View {
        ContentUnavailableView("No recipes yet",
                               systemImage:"list.bullet.rectangle")
    }
}
