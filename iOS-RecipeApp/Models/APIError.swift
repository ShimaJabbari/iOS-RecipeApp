import Foundation

enum APIError: LocalizedError {
    case invalidResponse
    case malformed
    case empty
    case decoding(Error)
    case underlying(Error)
    
    var underlying: Error? {
        if case .underlying(let err) = self { return err }
        return nil
    }

    var errorDescription: String? {
        switch self {
        case .invalidResponse: return "Invalid response."
        case .malformed:       return "The data is malformed."
        case .empty:           return "No recipes were found."
        case .decoding(let e): return "Could not decode JSON – \(e.localizedDescription)"
        case .underlying(let e):return e.localizedDescription
        }
    }
}
