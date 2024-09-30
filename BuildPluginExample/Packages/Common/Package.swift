// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Common",
  defaultLocalization: "en",
  platforms: [.iOS(.v15)],
  products: [
    .library(name: "Common", targets: ["Common"]),
    .library(name: "CommonTestingSupport", targets: ["CommonTestingSupport"]),
  ],

  dependencies: [
    .package(name: "BuildPlugins", path: "../BuildPlugins"),
  ],

  targets: [
    .target(
      name: "Common",
      resources: [
        .process("Resources"),
      ],
      plugins: [
        .plugin(name: "PackageBundlePlugin", package: "BuildPlugins")
      ]
    ),
    .target(name: "CommonTestingSupport", dependencies: ["Common"]),
    .testTarget(
      name: "CommonTests",
      dependencies: [
        "Common",
        "CommonTestingSupport"
      ]),
  ]
)
