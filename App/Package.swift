// swift-tools-version:5.10
import PackageDescription

let package = Package(
  name: "App",
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser.git", exact: "1.2.0"),
  ],
  targets: [
    .executableTarget(
      name: "App",
      dependencies: [.product(name: "ArgumentParser", package: "swift-argument-parser")]
    ),
  ]
)
