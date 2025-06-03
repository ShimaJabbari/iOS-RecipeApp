import SwiftUI

private struct APIServiceKey: EnvironmentKey {
    static let defaultValue: APIServiceProtocol = APIService()
}

private struct ImageCacheKey: EnvironmentKey {
    static let defaultValue: DiskCache = DiskCache()
}

extension EnvironmentValues {
    var apiService: APIServiceProtocol {
        get { self[APIServiceKey.self] }
        set { self[APIServiceKey.self] = newValue }
    }

    var imageCache: DiskCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}

@main
struct RecipeApp: App {

    private let api   = APIService()
    private let cache = DiskCache()

    var body: some Scene {
        WindowGroup {
            RecipeListView()
                .environment(\.apiService, api)
                .environment(\.imageCache, cache)
        }
    }
}
