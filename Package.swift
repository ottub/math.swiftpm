// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "TestApp",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .executable(name: "TestApp", targets: ["TestApp"])
    ],
    targets: [
        .executableTarget(
            name: "TestApp",
            path: "Sources/TestApp",
            resources: [.process("Resources")]
        )
    ]
)
