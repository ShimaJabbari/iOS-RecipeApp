import XCTest
@testable import iOS_RecipeApp

final class APIServiceTests: XCTestCase {
    func testFetchReturnsData() async throws {
        let api      = APIService()
        let recipes  = try await api.fetchRecipes(from: .allRecipes)
        XCTAssertFalse(recipes.isEmpty)
    }

    func testMalformedThrows() async {
        let api = APIService()
        do {
            _ = try await api.fetchRecipes(from: .malformed)
            XCTFail("Should throw")
        } catch is APIError { }
        catch { XCTFail("Wrong error") }
    }
}
