//
//  PageController.swift
//  PersonalWebSiteOnSwift
//
//  Created by Yura Voevodin on 21.05.17.
//
//

import Vapor
import HTTP

final class PageController: ResourceRepresentable {
    let view: ViewRenderer
    init(_ view: ViewRenderer) {
        self.view = view
    }
    
    func index(_ req: Request) throws -> ResponseRepresentable {
        return try view.make("index")
    }
    
    func makeResource() -> Resource<String> {
        return Resource(
            index: index
        )
    }
}
