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
    
    // MARK: Properties
    
    let view: ViewRenderer
    
    // MARK: Initialization
    
    init(_ view: ViewRenderer) {
        self.view = view
    }
    
    // MARK: Methods
    
    func index(_ req: Request) throws -> ResponseRepresentable {
        // Try to find page with path
        guard let page = try Page.makeQuery().filter("path", "/").first() else {
            throw Abort.notFound
        }
        // Make view
        return try view.make("index", try page.makeNode(in: nil))
    }
    
    func show(_ req: Request, _ string: String) throws -> ResponseRepresentable {
        // Try to find page with path
        guard let page = try Page.makeQuery().filter("path", string).first() else {
            throw Abort.notFound
        }
        // Make view
        let template = page.template ?? "index"
        return try view.make(template, try page.makeNode(in: nil))
    }
    
    // MARK: Resource
    
    func makeResource() -> Resource<String> {
        return Resource(
            index: index,
            show: show
        )
    }
}
