import SwiftUI

struct RecipeListView: View {
    @Environment(\.apiService) private var api
    @Environment(\.imageCache) private var cache
    @StateObject private var vm = RecipeListViewModel()

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Recipes")
        }
        // automatic first load
        .task        { await vm.refresh() }
        // pull-to-refresh
        .refreshable { await vm.refresh() }
    }

    @ViewBuilder private var content: some View {
        switch vm.state {

        case .idle, .loading:
            ProgressView("Loading…")
                .frame(maxWidth: .infinity, maxHeight: .infinity)

        case .empty:
            EmptyStateView()

        case .failed(let msg):
            ErrorStateView(message: msg) {
                Task { await vm.refresh() }          // retry button
            }

        case .loaded(let recipes):
            List(recipes.map(RecipeRowViewModel.init(recipe:))) { rowVM in
                NavigationLink {
                    if let recipe = recipes.first(where: { $0.id == rowVM.id }) {
                        RecipeDetailView(viewModel: .init(recipe: recipe))
                    }
                } label: {
                    RecipeRowView(viewModel: rowVM, cache: cache)
                }
            }
            .listStyle(.plain)
        }
    }
}
