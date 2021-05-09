// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Base64URL",
    products: [
        .library(
            name: "Base64URL",
            targets: ["Base64URL"]
        ),
        .library(
            name: "Base64URLDynamic",
            type: .dynamic,
            targets: ["Base64URL"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Base64URL",
            dependencies: []
        ),
        .testTarget(
            name: "Base64URLTests",
            dependencies: ["Base64URL"]
        ),
    ]
)
