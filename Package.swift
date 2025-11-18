// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "KillPortApp",
    platforms: [
        .macOS(.v11)
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "KillPortApp",
            dependencies: [],
            path: "Sources"
        )
    ]
)
