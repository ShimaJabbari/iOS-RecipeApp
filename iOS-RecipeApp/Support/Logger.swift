import OSLog
enum Log {
    static let api   = Logger(subsystem:"com.example.recipeapp", category:"api")
    static let cache = Logger(subsystem:"com.example.recipeapp", category:"cache")
}
