// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "InstrumentKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7),
    ],
    products: [
        .library(name: "InstrumentKit", targets: ["InstrumentKit"]),
        .library(name: "NoteKit", targets: ["NoteKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/jpsim/Yams", from: "5.0.1"),
        .package(url: "https://github.com/swift-kipple/Tools", .upToNextMinor(from: "0.2.3")),
    ],
    targets: [
        // Product Targets
        .target(
            name: "InstrumentKit",
            dependencies: [
                .product(name: "Yams", package: "Yams"),
                .target(name: "NoteKit"),
            ],
            resources: [
                .process("Resources"),
            ]
        ),
        .target(
            name: "NoteKit",
            dependencies: []
        ),
        // Test Targets
        .testTarget(
            name: "InstrumentKitTests",
            dependencies: [
                .target(name: "InstrumentKit"),
            ]
        ),
        .testTarget(
            name: "NoteKitTests",
            dependencies: [
                .target(name: "NoteKit"),
            ]
        ),
    ]
)
