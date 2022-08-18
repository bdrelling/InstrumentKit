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
        .library(name: "Frequency", targets: ["Frequency"]),
        .library(name: "InstrumentKit", targets: ["InstrumentKit"]),
        .library(name: "NoteKit", targets: ["NoteKit"]),
    ],
    dependencies: [
        // Development
        .package(url: "https://github.com/swift-kipple/Tools", .upToNextMinor(from: "0.2.3")),
    ],
    targets: [
        // Product Targets
        .target(
            name: "Frequency",
            dependencies: [
                .target(name: "NoteKit"),
            ]
        ),
        .target(
            name: "InstrumentKit",
            dependencies: [
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
            name: "NoteKitTests",
            dependencies: [
                .target(name: "NoteKit"),
            ]
        ),
    ]
)
