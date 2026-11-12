// swift-tools-version:5.10
import PackageDescription

let package = Package(
  name: "Tool",
  dependencies: [
    .package(url: "https://github.com/apple/swift-log.git", exact: "1.17.0"),
  ],
  targets: [
    .target(name: "Tool", dependencies: [.product(name: "Logging", package: "swift-log")]),
  ]
)
