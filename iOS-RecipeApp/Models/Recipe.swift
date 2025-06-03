import Foundation

struct Recipe: Identifiable, Equatable {
    let id: UUID
    let cuisine: String
    let name: String
    let smallPhotoURL: URL?
    let largePhotoURL: URL?
    let sourceURL: URL?
    let youtubeURL: URL?
}

extension Recipe {
    init(dto: RecipeDTO) {
        self.id            = dto.uuid
        self.cuisine       = dto.cuisine
        self.name          = dto.name
        self.smallPhotoURL = dto.photoURLSmall
        self.largePhotoURL = dto.photoURLLarge
        self.sourceURL     = dto.sourceURL
        self.youtubeURL    = dto.youtubeURL
    }
}
