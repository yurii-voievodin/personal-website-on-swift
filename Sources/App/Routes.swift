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
        
        let trolleybusSchedule = TrolleybusScheduleController(view)
        builder.add(.post, "trolleybus_schedule", value: trolleybusSchedule.search)
        builder.add(.get, "trolleybus_schedule", value: trolleybusSchedule.index)
    }
}
