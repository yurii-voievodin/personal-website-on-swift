//
//  Session.swift
//  PersonalWebSiteOnSwift
//
//  Created by Yura Voevodin on 21.05.17.
//
//

import Vapor
import FluentProvider
import HTTP

final class Session: Model {
    let storage = Storage()
    
    // MARK: Properties
    
    var day: Int
    var month: Int
    var year: Int
    var requests: Int
    
    // MARK: Initialization
    
    init(day: Int, month: Int, year: Int, requests: Int) {
        self.day = day
        self.month = month
        self.year = year
        self.requests = requests
    }
    
    // MARK: Fluent Serialization
    
    /// Initializes the Session from the
    /// database row
    init(row: Row) throws {
        day = try row.get("day")
        month = try row.get("month")
        year = try row.get("year")
        requests = try row.get("requests")
    }
    
    /// Serializes the Session to the database
    func makeRow() throws -> Row {
        var row = Row()
        try row.set("day", day)
        try row.set("month", month)
        try row.set("year", year)
        try row.set("requests", requests)
        return row
    }
}

// MARK: - Preparation

extension Session: Preparation {
    
    static func prepare(_ database: Database) throws {
        try database.create(self, closure: { builder in
            builder.id()
            builder.int("day")
            builder.int("month")
            builder.int("year")
            builder.int("requests")
        })
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
