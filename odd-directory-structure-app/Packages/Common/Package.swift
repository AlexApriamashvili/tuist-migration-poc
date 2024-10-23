// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Common",
  defaultLocalization: "en",
  platforms: [.iOS(.v15)],
  products: [
    .library(name: "Common", type: .dynamic, targets: ["Common"]),
    .library(name: "CommonTestingSupport", type: .dynamic, targets: ["CommonTestingSupport"]),
  ],

  dependencies: [],

  targets: [
    
    .target(
      name: "Common",
      resources: [
        .process("Resources"),
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
