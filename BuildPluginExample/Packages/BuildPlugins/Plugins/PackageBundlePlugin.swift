import PackagePlugin

@main
struct PackageBundlePlugin: BuildToolPlugin {

  func createBuildCommands(
    context: PluginContext,
    target: Target)
    async throws -> [Command]
  {
    if target.sourceModule == nil { return [] }

    let output = context.pluginWorkDirectory.appending(subpath: Constant.generatedBundleResolverFilename)

    return [
      .buildCommand(
        displayName: Constant.displayName(for: target.name),
        executable: try context.tool(named: Constant.generatorToolName).path,
        arguments: [
          context.package.displayName,
          target.name,
          output
        ],
        inputFiles: [],
        outputFiles: [output]
      )
    ]
  }
}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension PackageBundlePlugin: XcodeBuildToolPlugin {
    // Entry point for creating build commands for targets in Xcode projects.
  func createBuildCommands(
    context: XcodePluginContext,
    target: XcodeTarget)
    throws -> [Command]
  {
    if target.inputFiles.isEmpty { return [] }

    print("context.xcodeProject.displayName: \(context.xcodeProject.displayName)")
    print("target.displayName: \(target.displayName)")

    let output = context.pluginWorkDirectory.appending(subpath: Constant.generatedBundleResolverFilename)

    return [
      .buildCommand(
        displayName: Constant.displayName(for: target.displayName),
        executable: try context.tool(named: Constant.generatorToolName).path,
        arguments: [
          context.xcodeProject.displayName,
          target.displayName,
          output
        ],
        inputFiles: [],
        outputFiles: [output]
      )
    ]
  }
}

#endif

private enum Constant {
  static let generatedBundleResolverFilename = "ResourceBundle.g.swift"
  static let generatorToolName = "CustomBundleGenerator"

  static func displayName(for targetName: String) -> String {
    "Generating correct Bundle extension for \(targetName)..."
  }
}
