import Foundation

@MainActor
final class RecipeListViewModel: ObservableObject {

    enum State { case idle, loading, loaded([Recipe]), empty, failed(String) }

    @Published private(set) var state: State = .idle

    private let api: APIServiceProtocol
    private var isFetching = false

    init(api: APIServiceProtocol = APIService()) { self.api = api }
    
    func toggleFavorite(id:UUID){
        guard case .loaded(var list) = state else {return}
        if let i = list.firstIndex(where: { $0.id == id}){
            list[i].isFavorite.toggle()
            state = .loaded(list)
        }
    }
    
    func refresh() async {
        guard isFetching == false else { return }
        isFetching = true
        defer { isFetching = false }

        let previous = state
        state = .loading

        do {
            let recipes = try await api.fetchRecipes(from: .allRecipes)
            state = recipes.isEmpty ? .empty : .loaded(recipes)

        } catch APIError.empty {
            state = .empty

        } catch let APIError.underlying(inner as URLError)
                where inner.code == .cancelled {
            state = previous

        } catch let urlErr as URLError
                where urlErr.code == .cancelled {
            state = previous

        } catch {                                               
            state = .failed(error.localizedDescription)
        }
    }
}
