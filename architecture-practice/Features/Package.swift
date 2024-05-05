// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.macOS(.v10_15), .iOS(.v17)],
    products: [
        .library(name: "Features", targets: ["Features"])
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", from: "1.10.0")

//        .package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.0")

    ],
    targets: [
//        .macro(
//            name: "MacroImplement",
//            dependencies: [
//                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
//                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
//            ]
//        ),

        .target(
            name: "Features",
            dependencies: [
//                "MacroImplement",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ]
        ),
        .testTarget(
            name: "FeaturesTests",
            dependencies: [
                "Features"
//                "MacroImplement"
            ]
        )
    ]
)
