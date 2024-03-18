// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v17)],
    products: [
        .library(name: "Features", targets: ["Features"])
    ],
    dependencies: [
        .package(url: "https://github.com/vivalalova/SwiftUIViewRepresentable.git", from: "0.1.0")
    ],
    targets: [
        .target(
            name: "Features",
            dependencies: [
                .product(name: "SwiftUIViewRepresentable", package: "SwiftUIViewRepresentable")
            ]
        ),
        .testTarget(name: "FeaturesTests", dependencies: ["Features"])
    ]
)
