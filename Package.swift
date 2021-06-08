// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Sodium",
    products: [
        .library(
            name: "Sodium",
            targets: ["Sodium"]),
    ],
    targets: [
        .target(
            name: "Sodium",
            dependencies: [],
            path: "Sodium",
            exclude: ["Info.plist"]),
        .testTarget(
            name: "SodiumTests",
            dependencies: ["Sodium"],
            exclude: ["Info.plist"]),
    ]
)
