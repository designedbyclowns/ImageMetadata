// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "ImageMetadata",
    defaultLocalization: "en-US",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
        .watchOS(.v10),
        .tvOS(.v17),
    ],
    products: [
        .library(name: "ImageMetadata", targets: ["ImageMetadata"]),
        .executable(name: "imgmd", targets: ["imgmd"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMinor(from: "1.4.0")),
        .package(url: "https://github.com/apple/swift-numerics", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "ImageMetadata"
        ),
        .testTarget(
            name: "ImageMetadataTests",
            dependencies: [
                "ImageMetadata",
                .product(name: "Numerics", package: "swift-numerics"),
            ],
            resources: [
                .process("Resources")
            ]
        ),
        .executableTarget(
            name: "imgmd",
            dependencies: [
                "ImageMetadata",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]
        ),
        .testTarget( name: "imgmdTests", dependencies: ["imgmd"]),
    ]
)
