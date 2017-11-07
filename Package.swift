// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "PersonalWebSiteOnSwift",
    products: [
        .library(name: "App", targets: ["App"]),
        .executable(name: "Run", targets: ["Run"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", .upToNextMajor(from: "2.1.0")),
        .package(url: "https://github.com/vapor/fluent-provider.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/vapor/leaf-provider.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/vapor/postgresql-provider.git", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/vapor-community/markdown-provider", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "FluentProvider", "LeafProvider", "PostgreSQLProvider", "MarkdownProvider"],
                exclude: [
                    "Config",
                    "Database",
                    "Public",
                    "Resources",
                    ]),
        .target(name: "Run", dependencies: ["App"])
    ]
)
