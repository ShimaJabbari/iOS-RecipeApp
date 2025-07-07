import Foundation

struct RecipesResponseDTO: Codable { let recipes: [RecipeDTO] }

struct RecipeDTO: Codable {
    let cuisine: String
    let name: String
    let photo_url_large: String?
    let photo_url_small: String?
    let uuid: UUID
    let source_url: String?
    let youtube_url: String?
}

extension RecipeDTO {
    var photoURLLarge: URL? { URL(string: photo_url_large ?? "") }
    var photoURLSmall: URL? { URL(string: photo_url_small ?? "") }
    var sourceURL:     URL? { URL(string: source_url     ?? "") }
    var youtubeURL:    URL? { URL(string: youtube_url    ?? "") }
}
