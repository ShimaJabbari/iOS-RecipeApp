import SwiftUI

struct RecipeDetailView: View {
    let viewModel: RecipeDetailViewModel
    private let cache: DiskCache
    @StateObject private var loader: ImageLoader

    init(viewModel: RecipeDetailViewModel, cache: DiskCache = DiskCache()) {
        self.viewModel = viewModel
        self.cache     = cache
        _loader        = StateObject(wrappedValue: ImageLoader(url: viewModel.largePhotoURL, cache: cache))
    }

    var body: some View {
        ScrollView {
            VStack(alignment:.leading,spacing:16) {
                Group{
                    if let ui = loader.image {
                        Image(uiImage: ui)
                            .resizable()
                            .scaledToFill()
                    } else {
                        Rectangle()
                            .fill(.secondary.opacity(0.2))
                            .overlay{ProgressView()}
                    }
                }
                .frame(height:240)
                .clipped()

                Text(viewModel.cuisine)
                    .font(.subheadline).foregroundColor(.secondary)

                if let source = viewModel.sourceURL {
                    Link("View Source", destination: source)
                        .buttonStyle(.borderedProminent)
                }
                if let yt = viewModel.youtubeURL {
                    Link("Watch on YouTube", destination: yt)
                }
            }
            .padding()
            .navigationTitle(viewModel.title)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear { loader.load() }
    }
}

