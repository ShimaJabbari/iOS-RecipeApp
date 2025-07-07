import Foundation

struct RecipeRowViewModel: Identifiable, Equatable {
    let id: UUID
    let name: String
    let cuisine: String
    let photoURL: URL?
    
    var isFavorite: Bool

    
    init(recipe: Recipe) {
        id       = recipe.id
        name     = recipe.name
        cuisine  = recipe.cuisine
        photoURL = recipe.smallPhotoURL
        
        isFavorite = recipe.isFavorite
 
    }
}
