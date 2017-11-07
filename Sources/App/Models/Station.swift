//
//  Station.swift
//  App
//
//  Created by Yura Voevodin on 07.11.17.
//

import Vapor
import FluentProvider
import HTTP

final class Station: Model {
    let storage = Storage()
    
    // MARK: Properties
    
    var name: String
    
    // MARK: Fluent Serialization
    
    /// Initializes from the
    /// database row
    init(row: Row) throws {
        name = try row.get("name")
    }
    
    /// Serializes to the database
    func makeRow() throws -> Row {
        var row = Row()
        try row.set("name", name)
        return row
    }
}

// MARK: - NodeRepresentable

extension Station: NodeRepresentable {
    
    func makeNode(in context: Context?) throws -> Node {
        var node = Node(context)
        try node.set("id", id)
        try node.set("name", name)
        try node.set("routes", routes.all())
        return node
    }
}

// MARK: - Relationships

extension Station {
    var routes: Children<Station, Route> {
        return children()
    }
}

// MARK: - Preparation

extension Station: Preparation {
    
    static func prepare(_ database: Database) throws {
        try database.create(self, closure: { builder in
            builder.id()
            builder.string("name")
        })
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
