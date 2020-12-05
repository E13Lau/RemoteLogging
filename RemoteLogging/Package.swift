// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RemoteLogging",
    platforms: [
        .iOS(.v9),
        .tvOS(.v9),
        .macOS(.v10_10)
    ],
    products: [
        .library(
            name: "RemoteLogging",
            targets: ["RemoteLogging"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
        .package(url: "https://github.com/Building42/Telegraph.git", from: "0.28.0"),
    ],
    targets: [
        .target(
            name: "RemoteLogging",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
                "Telegraph",
            ],
            resources: [
                .process("Resources"),
                .copy("index.html")
            ]
        ),
        .testTarget(
            name: "RemoteLoggingTests",
            dependencies: ["RemoteLogging"]),
    ]
)
