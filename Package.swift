// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "Math",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(name: "Math", targets: ["Math"]) // core library
    ],
    targets: [
        .target(
            name: "Math",
            path: "Sources/Math",
            resources: [.process("Resources")]
        ),
        .executableTarget(
            name: "TestApp",
            dependencies: ["Math"],
            path: "Sources/TestApp"
        )
    ]
)
