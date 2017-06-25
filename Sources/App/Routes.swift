import Vapor

final class Routes: RouteCollection {
    let view: ViewRenderer
    init(_ view: ViewRenderer) {
        self.view = view
    }
    
    func build(_ builder: RouteBuilder) throws {
        // Pages
        builder.resource("/", PageController(view))
        
        // Posts
        builder.resource("posts", PostController(view))
    }
}
