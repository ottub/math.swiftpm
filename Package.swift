// swift-tools-version:5.8
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
        .target(
            name: "TestApp",
            path: "Sources/TestApp"
        )
    ]
)
