// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "transparency",
    platforms: [
      .macOS(.v10_12)
    ],
    products: [
        .executable(
            name: "transparency",
            targets: ["transparency"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.0.6"),
    ],
    targets: [
        .target(
            name: "transparency",
            dependencies: [
                .product(name: "ArgumentParser",
                package: "swift-argument-parser")
            ]
        ),
    ],
    swiftLanguageVersions: [
      .v5
    ]
)
