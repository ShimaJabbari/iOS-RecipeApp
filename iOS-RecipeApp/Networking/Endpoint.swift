import Foundation

enum Endpoint {
    case allRecipes, malformed, empty

    var url: URL {
        switch self {
        case .allRecipes: return URL(string:"https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
        case .malformed:  return URL(string:"https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!
        case .empty:      return URL(string:"https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!
        }
    }

    var request: URLRequest {
        var r = URLRequest(url: url)
        r.cachePolicy = .reloadIgnoringLocalCacheData
        return r
    }
}
