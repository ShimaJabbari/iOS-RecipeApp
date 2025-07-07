import SwiftUI

struct RecipeRowView: View {
    var viewModel: RecipeRowViewModel
    private let cache: DiskCache
    @StateObject private var loader: ImageLoader
    
    @EnvironmentObject private var listVM: RecipeListViewModel
    
    

    init(viewModel: RecipeRowViewModel, cache: DiskCache) {
        self.viewModel = viewModel
        self.cache     = cache
        _loader        = StateObject(wrappedValue: ImageLoader(url: viewModel.photoURL, cache: cache))
    }

    var body: some View {
        HStack {
            Group {
                if let ui = loader.image {
                    Image(uiImage: ui)
                        .resizable()
                        .scaledToFill()
                } else {
                    Rectangle()
                        .fill(.secondary.opacity(0.2))
                        .overlay { ProgressView() }
                }
            }
            .frame(width:60,height:60)
            .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment:.leading,spacing:4) {
                Text(viewModel.name).font(.headline)
                Text(viewModel.cuisine).font(.subheadline).foregroundColor(.secondary)
            }
           
            Spacer(minLength: 10)
            Button {
                listVM.toggleFavorite(id: viewModel.id)
            } label: {
                Image(systemName: viewModel.isFavorite ? "heart.fill" : "heart")
                    .foregroundStyle(.tint)
            }
            .buttonStyle(.plain)

       
       
            

            
    
  
        }
        .accessibilityElement(children: .ignore)                       // ★ ADD
        .accessibilityLabel("\(viewModel.name), \(viewModel.cuisine) cuisine")

        .onAppear { loader.load() }
    }
}
