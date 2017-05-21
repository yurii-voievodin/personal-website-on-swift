//
//  MySessionsMiddleware.swift
//  PersonalWebSiteOnSwift
//
//  Created by Yura Voevodin on 21.05.17.
//
//

import HTTP

final class MySessionsMiddleware: Middleware {
    
    func respond(to request: Request, chainingTo next: Responder) throws -> Response {
        let response = try next.respond(to: request)
        
        if let (day, month, year) = Date().calendarComponents {
            do {
                if let session = try Session.makeQuery()
                    .filter("year", year)
                    .filter("month", month)
                    .filter("day", day)
                    .first() {
                    session.requests += 1
                    try session.save()
                } else {
                    let newSession = Session(day: day, month: month, year: year, requests: 1)
                    try newSession.save()
                }
            } catch  {
                print(error.localizedDescription)
            }
        }
        
        return response
    }
}
