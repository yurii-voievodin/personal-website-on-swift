//
//  Route.swift
//  App
//
//  Created by Yura Voevodin on 07.11.17.
//

import Vapor
import FluentProvider
import HTTP

final class Route: Model {
    let storage = Storage()
    
    // MARK: Properties
    
    let stationID: Identifier?
    var name: String
    
    // MARK: - Initialization
    
    init(name: String) {
        self.name = name
        stationID = nil
    }
    
    // MARK: Fluent Serialization
    
    /// Initializes from the
    /// database row
    init(row: Row) throws {
        name = try row.get("name")
        
        // Relationships
        stationID = try row.get("station_id")
    }
    
    /// Serializes to the database
    func makeRow() throws -> Row {
        var row = Row()
        try row.set("name", name)
        
        // Relationships
        try row.set("station_id", stationID)
        
        return row
    }
}

// MARK: - NodeRepresentable

extension Route: NodeRepresentable {
    
    func makeNode(in context: Context?) throws -> Node {
        var node = Node(context)
        try node.set("name", name)
        try node.set("records", records.all())
        return node
    }
}

// MARK: - Relationships

extension Route {
    var records: Children<Route, Record> {
        return children()
    }
}

// MARK: - Relationships

extension Route {
    var station: Parent<Route, Station> {
        return parent(id: stationID)
    }
}

// MARK: - Preparation

extension Route: Preparation {
    
    static func prepare(_ database: Database) throws {
        try database.create(self, closure: { builder in
            builder.id()
            builder.parent(Station.self)
            builder.string("name")
        })
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
