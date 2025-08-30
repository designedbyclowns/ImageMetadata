// swift-tools-version: 6.2

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
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMajor(from: "1.6.0")),
        .package(url: "https://github.com/apple/swift-numerics", .upToNextMajor(from: "1.0.0"))
    ],
    targets: [
        .target(
            name: "ImageMetadata",
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
        .target(
            name: "Shared",
            resources: [
                .process("Resources")
            ]
        ),
        .testTarget(
            name: "ImageMetadataTests",
            dependencies: [
                "ImageMetadata",
                "Shared",
                .product(name: "Numerics", package: "swift-numerics"),
            ],
        ),
        
        .testTarget(
            name: "imgmdTests",
            dependencies: [
                "imgmd",
                "Shared"
            ],
            resources: [
                .process("Resources")
            ],
        ),
        
    ]
)

for target in package.targets {
    var settings = target.swiftSettings ?? []
    settings.append(contentsOf: [
        .enableUpcomingFeature("InternalImportsByDefault")
    ])
    target.swiftSettings = settings
}
