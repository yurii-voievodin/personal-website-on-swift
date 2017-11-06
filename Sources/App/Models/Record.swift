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
    
    var holiday: String
    var route: Int
    var weekday: String
    
    // MARK: Fluent Serialization
    
    /// Initializes the Session from the
    /// database row
    init(row: Row) throws {
        holiday = try row.get("holiday")
        route = try row.get("route")
        weekday = try row.get("weekday")
    }
    
    /// Serializes the Session to the database
    func makeRow() throws -> Row {
        var row = Row()
        try row.set("holiday", holiday)
        try row.set("route", route)
        try row.set("weekday", weekday)
        return row
    }
}

// MARK: - NodeRepresentable

extension Record: NodeRepresentable {
    
    func makeNode(in context: Context?) throws -> Node {
        var node = Node(context)
        try node.set("holiday", holiday)
        try node.set("route", route)
        try node.set("weekday", weekday)
        return node
    }
}

// MARK: - Preparation

extension Record: Preparation {
    
    static func prepare(_ database: Database) throws {
        try database.create(self, closure: { builder in
            builder.id()
            builder.string("holiday")
            builder.int("route")
            builder.string("weekday")
        })
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
