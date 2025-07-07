import Foundation

protocol APIServiceProtocol {
    func fetchRecipes(from endpoint: Endpoint) async throws -> [Recipe]
}

final class APIService: APIServiceProtocol {

    func fetchRecipes(from endpoint: Endpoint = .allRecipes) async throws -> [Recipe] {
        let (data, response) = try await URLSession.shared.data(for: endpoint.request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw APIError.invalidResponse
        }

        let root = try JSONDecoder().decode(RecipesResponseDTO.self, from: data)
        guard root.recipes.isEmpty == false else { throw APIError.empty }

        return root.recipes.map(Recipe.init(dto:))
    }
}
