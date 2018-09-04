// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Sodium",
    products: [
        .library(
            name: "Sodium",
            targets: ["Sodium"]
        ),
    ],
    dependencies: [
        //
    ],
    targets: [
        .target(
            name: "Sodium",
            dependencies: ["Clibsodium"]
        ),
        .target(
            name: "Clibsodium",
            dependencies: []
        ),
        .testTarget(
            name: "SodiumTests",
            dependencies: ["Sodium"]
        ),
    ]
)
