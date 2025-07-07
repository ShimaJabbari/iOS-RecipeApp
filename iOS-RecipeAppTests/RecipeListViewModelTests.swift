import XCTest
@testable import iOS_RecipeApp

actor StubAPI: APIServiceProtocol {
    var result: Result<[Recipe],Error>
    init(_ result: Result<[Recipe],Error>) { self.result = result }
    func fetchRecipes(from _:Endpoint) async throws -> [Recipe] { try result.get() }
}

final class RecipeListViewModelTests: XCTestCase {
    func testLoadedState() async {
        let sample = Recipe(id:.init(), cuisine:"Test", name:"Dummy",
                            smallPhotoURL:nil, largePhotoURL:nil,
                            sourceURL:nil, youtubeURL:nil)
        let vm = await RecipeListViewModel(api: StubAPI(.success([sample])))
        await vm.refresh()
        if case .loaded(let list) = await vm.state {
            XCTAssertEqual(list,[sample])
        } else { XCTFail() }
    }
}
