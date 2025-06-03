import SwiftUI
struct ErrorStateView: View {
    let message: String
    let retry: () -> Void

    var body: some View {
        VStack(spacing:12) {
            ContentUnavailableView("Something went wrong",
                                   systemImage:"exclamationmark.triangle",
                                   description: Text(message))
            Button("Try again", action: retry)
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
