// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "BCSSwiftTools",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(name: "BCSSwiftTools", targets: ["BCSSwiftTools"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "BCSSwiftTools",
            dependencies: [],
            path: "BCSSwiftTools" // Необходим чтобы не переделывать пути на Source
        )
    ]
)
