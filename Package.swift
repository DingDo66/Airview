// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Airview",
    platforms: [.macOS(.v13)],
    products: [
        .executable(name: "Airview", targets: ["AirviewApp"])
    ],
    targets: [
        .target(name: "AirviewCore"),
        .target(name: "AirviewViewer", dependencies: ["AirviewCore"]),
        .target(name: "AirviewGrid", dependencies: ["AirviewCore"]),
        .target(name: "AirviewPin", dependencies: ["AirviewCore"]),
        .executableTarget(
            name: "AirviewApp",
            dependencies: ["AirviewCore", "AirviewViewer", "AirviewGrid", "AirviewPin"]
        ),
        .testTarget(name: "AirviewCoreTests", dependencies: ["AirviewCore"])
    ]
)
