import FluentProvider
import LeafProvider
import PostgreSQLProvider
import MarkdownProvider

extension Config {
    public func setup() throws {
        // allow fuzzy conversions for these types
        // (add your own types here)
        Node.fuzzy = [Row.self, JSON.self, Node.self]
        
        try setupProviders()
        try setupPreparations()
        try setupMiddlewares()
    }
    
    /// Configure providers
    private func setupProviders() throws {
        try addProvider(FluentProvider.Provider.self)
        try addProvider(LeafProvider.Provider.self)
        try addProvider(PostgreSQLProvider.Provider.self)
        try addProvider(MarkdownProvider.Provider.self)
    }
    
    /// Add all models that should have their
    /// schemas prepared before the app boots
    private func setupPreparations() throws {
        preparations += [
            Page.self,
            Post.self,
            Station.self,
            Route.self,
            Record.self,
            Session.self
            ] as [Preparation.Type]
    }
    
    private func setupMiddlewares() throws {
        addConfigurable(middleware: MySessionsMiddleware(), name: "my-sessions")
    }
}
