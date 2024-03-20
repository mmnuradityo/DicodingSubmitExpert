// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DSSearch",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "DSSearch",
            targets: ["DSSearch"]),
    ],
    dependencies: [
      .package(url: "https://github.com/mmnuradityo/DSCore.git", .upToNextMajor(from: "1.0.2")),
      .package(url: "https://github.com/square/Cleanse.git", .upToNextMajor(from: "4.0.0")),
      .package(path: "../DSBase")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "DSSearch",
            dependencies: [
              "DSCore",
              "Cleanse",
              "DSBase"
            ]),
        .testTarget(
            name: "DSSearchTests",
            dependencies: [
              "DSSearch"
            ]),
    ]
)
