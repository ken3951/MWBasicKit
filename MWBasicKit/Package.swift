// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MWBasicKit",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MWBasicKit",
            targets: ["MWBasicKitCategory","MWBasicKitSecurity","MWBasicKitCore"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MWBasicKitCategory",
            path: "Sources/MWBasicKit/Category"),
        .target(
            name: "MWBasicKitSecurity",
            path: "Sources/MWBasicKit/Security"),
        .target(
            name: "MWBasicKitCore",
            dependencies: ["MWBasicKitCategory"],
            path: "Sources/MWBasicKit/Core"),
        .testTarget(
            name: "MWBasicKitTests",
            dependencies: ["MWBasicKitCategory","MWBasicKitSecurity","MWBasicKitCore"]),
    ]
)
