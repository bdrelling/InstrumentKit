// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "InstrumentKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11),
        .macOS(.v10_13),
        .tvOS(.v11),
        .watchOS(.v4),
    ],
    products: [
        .library(name: "Frequency", targets: ["Frequency"]),
        .library(name: "InstrumentKit", targets: ["InstrumentKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/AudioKit/Tonic", .upToNextMinor(from: "1.0.4")),
        // Development
        .package(url: "https://github.com/swift-kipple/Tools", .upToNextMinor(from: "0.2.3")),
    ],
    targets: [
        // Product Targets
        .target(
            name: "Frequency",
            dependencies: [
                .product(name: "Tonic", package: "Tonic"),
            ]
        ),
        .target(
            name: "InstrumentKit",
            dependencies: [
                .product(name: "Tonic", package: "Tonic"),
            ],
            resources: [
                .process("Resources"),
            ]
        ),
        // Test Targets
        .testTarget(
            name: "FrequencyTests",
            dependencies: [
                .target(name: "Frequency"),
            ]
        ),
        .testTarget(
            name: "InstrumentKitTests",
            dependencies: [
                .target(name: "InstrumentKit"),
            ]
        ),
        .testTarget(
            name: "TonicTests",
            dependencies: [
                .product(name: "Tonic", package: "Tonic"),
            ]
        ),
    ]
)
