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
        .library(name: "NoteKit", targets: ["NoteKit"]),
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
                .target(name: "NoteKit"),
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

#if swift(>=5.5)
// Add Kipple Tools
package.dependencies.append(
    .package(url: "https://github.com/swift-kipple/Tools", .upToNextMinor(from: "0.2.3"))
)
#endif
