//
//  Record.swift
//  App
//
//  Created by Yura Voevodin on 06.11.17.
//

import Vapor
import FluentProvider
import HTTP

final class Record: Model {
    let storage = Storage()
    
    // MARK: Properties
    
    let routeID: Identifier?
    var holiday: String
    var weekday: String
    
    // MARK: Fluent Serialization
    
    /// Initializes the Session from the
    /// database row
    init(row: Row) throws {
        holiday = try row.get("holiday")
        weekday = try row.get("weekday")
        
        // Relationships
        routeID = try row.get("route_id")
    }
    
    /// Serializes the Session to the database
    func makeRow() throws -> Row {
        var row = Row()
        try row.set("holiday", holiday)
        try row.set("weekday", weekday)
        
        // Relationships
        try row.set("route_id", routeID)
        
        return row
    }
}

// MARK: - NodeRepresentable

extension Record: NodeRepresentable {
    
    func makeNode(in context: Context?) throws -> Node {
        var node = Node(context)
        try node.set("holiday", holiday)
        try node.set("weekday", weekday)
        return node
    }
}

// MARK: - Relationships

extension Record {
    var route: Parent<Record, Route> {
        return parent(id: routeID)
    }
}

// MARK: - Preparation

extension Record: Preparation {
    
    static func prepare(_ database: Database) throws {
        try database.create(self, closure: { builder in
            builder.id()
            builder.parent(Route.self)
            builder.string("holiday")
            builder.string("weekday")
        })
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
