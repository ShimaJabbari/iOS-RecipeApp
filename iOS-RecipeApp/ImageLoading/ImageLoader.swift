import SwiftUI

private let memoryCache: NSCache <NSURL, UIImage> = {
    let c = NSCache <NSURL, UIImage>()
    c.countLimit = 200
    return c
}()


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
        
        if let ui = memoryCache.object(forKey: url as NSURL){
            self.image = ui
            return
        }
      
  


        task = Task {
            if let data = await cache.data(for: url),
               let ui   = UIImage(data: data) {
                self.image = ui
                
                memoryCache.setObject(ui, forKey: url as NSURL)
                                
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
