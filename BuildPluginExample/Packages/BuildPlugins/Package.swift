// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "BuildPlugins",
  products: [
    .plugin(name: "PackageBundlePlugin", targets: ["PackageBundlePlugin"]),
  ],

  targets: [
    .executableTarget(name: "CustomBundleGenerator"),
    .plugin(
      name: "PackageBundlePlugin",
      capability: .buildTool(),
      dependencies: ["CustomBundleGenerator"]
    ),
  ]
)
