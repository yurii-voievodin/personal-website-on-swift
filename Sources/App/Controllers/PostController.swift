//
//  PostController.swift
//  PersonalWebSiteOnSwift
//
//  Created by Yura Voevodin on 21.05.17.
//
//

import Vapor
import HTTP

final class PostController: ResourceRepresentable {
    
    // MARK: Properties
    
    let view: ViewRenderer
    
    // MARK: Initialization
    
    init(_ view: ViewRenderer) {
        self.view = view
    }
    
    // MARK: Methods
    
    func index(request: Request) throws -> ResponseRepresentable {
        let posts = try Post.all()
        return try view.make("posts", [
            "posts": try posts.makeNode(in: nil),
            "title": "Привіт, це мій блог 🙋‍♂️",
            "description": "",
            "keywords": ""
            ]
        )
    }
    
    func show(_ req: Request, _ string: String) throws -> ResponseRepresentable {
        // Try to find post with path
        guard let post = try Post.makeQuery().filter("path", string).first() else {
            throw Abort.notFound
        }
        // Make view
        let template = post.template ?? "post"
        return try view.make(template, try post.makeNode(in: nil))
    }
    
    // MARK: Resource
    
    func makeResource() -> Resource<String> {
        return Resource(
            index: index,
            show: show
        )
    }
}
