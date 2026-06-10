// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "Math",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .executable(name: "TestApp", targets: ["TestApp"])
    ],
    targets: [
        .executableTarget(
            name: "TestApp",
            path: "Sources/TestApp"
        )
    ]
)
