import SwiftUI

@MainActor
final class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    private let url: URL?
    private let cache: DiskCache
    private var task: Task<Void,Never>?

    private static var inFlight: [URL:Task<UIImage?,Never>] = [:]
    
    init(url: URL?, cache: DiskCache) {
        self.url   = url
        self.cache = cache
    }
    deinit { task?.cancel() }

    func load() {
        guard let url else { return }

        if let existing = Self.inFlight[url] {
            task = Task { self.image = await existing.value }
            return
        }

        task = Task {
            if let data = await cache.data(for: url),
               let ui   = UIImage(data: data) {
                self.image = ui
                return
            }

            let fetch = Task<UIImage?,Never> {
                do {
                    let (blob, _) = try await URLSession.shared.data(from: url, delegate:nil)
                    await cache.insert(blob, for: url)
                    return UIImage(data: blob)
                } catch { return nil }
            }
            Self.inFlight[url] = fetch
            self.image = await fetch.value
            Self.inFlight[url] = nil
        }
    }
}
