// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "TestApp",
    platforms: [
        .iOS(.v26)
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
