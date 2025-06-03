import XCTest
@testable import iOS_RecipeApp

final class DiskCacheTests: XCTestCase {
    func testRoundTrip() async throws {
        let cache = DiskCache()                       
        let url   = URL(string: "https://example.com/a.png")!
        let data  = Data("abc".utf8)

        await cache.insert(data, for: url)
        let back = await cache.data(for: url)

        XCTAssertEqual(back, data)
    }

}
