import Vapor
import FluentProvider
import HTTP

final class Post: Model {
    let storage = Storage()
    
    // MARK: Properties
    
    var title: String
    var intro: String
    var content: String
    var path: String?
    var template: String?
    var keywords: String?
    var description: String?
    var image: String?
    
    // MARK: - Initialization
    
    init(title: String, intro: String, content: String, path: String?, template: String?, keywords: String?, description: String?) {
        self.title = title
        self.intro = intro
        self.content = content
        self.path = path
        self.template = template
        self.keywords = keywords
        self.description = description
        self.image = nil
    }
    
    // MARK: Fluent Serialization
    
    /// Initializes the Post from the
    /// database row
    init(row: Row) throws {
        title = try row.get("title")
        intro = try row.get("intro")
        content = try row.get("content")
        path = try row.get("path")
        template = try row.get("template")
        keywords = try row.get("keywords")
        description = try row.get("description")
        image = try row.get("image")
    }
    
    /// Serializes the Post to the database
    func makeRow() throws -> Row {
        var row = Row()
        try row.set("title", title)
        try row.set("intro", intro)
        try row.set("content", content)
        try row.set("path", path)
        try row.set("template", template)
        try row.set("keywords", keywords)
        try row.set("description", description)
        try row.set("image", description)
        return row
    }
}

// MARK: - Timestampable

extension Post: Timestampable { }

// MARK: - NodeRepresentable

extension Post: NodeRepresentable {
    
    func makeNode(in context: Context?) throws -> Node {
        var node = Node(context)
        try node.set("title", title)
        try node.set("intro", intro)
        try node.set("content", content)
        try node.set("path", path)
        try node.set("template", template)
        try node.set("keywords", keywords)
        try node.set("description", description)
        try node.set("updated_at", updatedAt?.dayMonthYear)
        return node
    }
}

// MARK: - Preparation

extension Post: Preparation {
    static func prepare(_ database: Database) throws {
        try database.create(self, closure: { builder in
            builder.id()
            builder.string("title")
            builder.custom("intro", type: "text")
            builder.custom("content", type: "text")
            builder.string("path", optional: true, unique: false, default: nil)
            builder.string("template", optional: true, unique: false, default: nil)
            builder.string("keywords", optional: true, unique: false, default: nil)
            builder.string("description", optional: true, unique: false, default: nil)
            builder.string("image", optional: true, unique: false, default: nil)
        })
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(self)
    }
}
