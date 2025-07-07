import Foundation

struct RecipeDetailViewModel {
    let recipe: Recipe
    var title: String        { recipe.name }
    var cuisine: String      { recipe.cuisine }
    var largePhotoURL: URL?  { recipe.largePhotoURL }
    var sourceURL: URL?      { recipe.sourceURL }
    var youtubeURL: URL?     { recipe.youtubeURL }
}
