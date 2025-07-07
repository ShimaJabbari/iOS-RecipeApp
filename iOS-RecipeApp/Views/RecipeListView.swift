import SwiftUI

struct RecipeListView: View {
    @Environment(\.apiService) private var api
    @Environment(\.imageCache) private var cache
    @StateObject private var vm = RecipeListViewModel()
    
    @State private var sortByCuisine = false
    
    @State private var query = ""
    


    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Recipes")
            
                .toolbar{
                    Button {
                        sortByCuisine.toggle()
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }

                }

        }.searchable(text: $query)
    
        
        
        .task        { await vm.refresh() }
        
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
            
            
            let filtered = query.isEmpty ? recipes : recipes.filter{ $0.name.localizedCaseInsensitiveContains(query)}
            
            let displayed = sortByCuisine ? filtered.sorted { $0.cuisine < $1.cuisine }: filtered.sorted{ $0.name < $1.name }
        
            
            
            List(displayed.map(RecipeRowViewModel.init(recipe:))) { rowVM in
                NavigationLink {
                    if let recipe = displayed.first(where: { $0.id == rowVM.id }) {
                        RecipeDetailView(viewModel: .init(recipe: recipe))


                    }
                } label: {
                    RecipeRowView(viewModel: rowVM, cache: cache)
                        .environmentObject(vm)
                        
                        
                }
            }
            .listStyle(.plain)
            
            
        }
    }
}

#Preview {
    RecipeListView()
}

