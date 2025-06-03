import Foundation
import CryptoKit

actor DiskCache {

    private let dir: URL
    private let fm = FileManager.default

    init(folderName: String = "RecipeImages") {
        let caches = fm.urls(for: .cachesDirectory, in: .userDomainMask).first!
        dir = caches.appendingPathComponent(folderName, isDirectory: true)
        try? fm.createDirectory(at: dir, withIntermediateDirectories: true)
    }

    func data(for url: URL) async -> Data? {
        let file = dir.appendingPathComponent(cacheKey(url))
        return try? Data(contentsOf: file)
    }

    func insert(_ data: Data, for url: URL) async {
        let file = dir.appendingPathComponent(cacheKey(url))
        if fm.fileExists(atPath: file.path) == false {
            try? data.write(to: file, options: .atomic)
        }
    }

    private func cacheKey(_ url: URL) -> String {
        let hash = SHA256.hash(data: Data(url.absoluteString.utf8))
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}
