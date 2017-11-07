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
        let stationID = req.query?["station"]?.int ?? 0
        let stations = try Station.all()
        let station = try Station.makeQuery().find(stationID)
        return try view.make(
            "trolleybus_schedule",
            [
                "title": "Розклад тролейбусів міста Суми",
                "description": "Розклад тролейбусів Суми, Тролейбуси міста Суми розклад",
                "keywords": "Суми, Тролейбуси, Розклад",
                "currentStation": try station.makeNode(in: nil),
                "stations": try stations.makeNode(in: nil)
            ]
        )
    }
    
    func search(_ req: Request) throws -> ResponseRepresentable {
        guard let station = req.data["station"]?.string else { throw Abort.badRequest }
        return Response(redirect: "/trolleybus_schedule?station=\(station)")
    }
}
