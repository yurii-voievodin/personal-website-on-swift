//
//  TrolleybusScheduleController.swift
//  App
//
//  Created by Yura Voevodin on 06.11.17.
//

import Vapor
import HTTP

final class TrolleybusScheduleController {
    
    // MARK: Properties
    
    let view: ViewRenderer
    
    // MARK: Initialization
    
    init(_ view: ViewRenderer) {
        self.view = view
    }
    
    // MARK: Methods
    
    func index(_ req: Request) throws -> ResponseRepresentable {
        let route = req.query?["route"]?.int ?? 0
        let records = try Record.makeQuery().filter("route", route).all()
        return try view.make(
            "trolleybus_schedule",
            [
                "title": "Розклад тролейбусів міста Суми",
                "description": "Розклад тролейбусів Суми, Тролейбуси міста Суми розклад",
                "keywords": "Суми, Тролейбуси, Розклад",
                "records": try records.makeNode(in: nil),
                "route": route
            ]
        )
    }
    
    func search(_ req: Request) throws -> ResponseRepresentable {
        guard let route = req.data["route"]?.string else { throw Abort.badRequest }
        return Response(redirect: "/trolleybus_schedule?route=\(route)")
    }
}
