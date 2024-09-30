import Foundation

let arguments = ProcessInfo().arguments
guard arguments.count > 3 else {
  print("CustomBundleGenerator: Missing command line arguments. Arguments provided: \(arguments)")
  exit(1)
}

let (packageName, targetName, output) = (arguments[1], arguments[2], arguments[3])

let outputURL = URL(fileURLWithPath: output)

let outputDirectory = outputURL.deletingLastPathComponent()
do {
    try FileManager.default.createDirectory(at: outputDirectory, withIntermediateDirectories: true, attributes: nil)
} catch {
    print("CustomBundleGenerator: Failed to create directory at path: \(outputDirectory). Error: \(error.localizedDescription)")
    exit(1)
}

do {
    try GeneratedCode
        .versatileBundleExtension
        .write(to: outputURL, atomically: true, encoding: .utf8)
    print("CustomBundleGenerator: File successfully written to \(output)")
} catch {
    print("CustomBundleGenerator: Failed to write file. Error: \(error.localizedDescription)")
    exit(1)
}


private enum GeneratedCode {
  /// the contents of this code snippet are identical to the ones generated as part of the `resource_bundle_accessor.swift`
  /// yet contain extra path candidates to address problems that occur when `xcodebuild`/SPM misses the resource copy (`CpResource`) stage
  /// this bundle extension also includes a potential fix for the SwiftUI previews
  ///
  /// The fix was inspired by: https://notificare.com/blog/2024/01/19/xcode-build-plugins/
  /// Also issue: https://developer.apple.com/forums/thread/664295
  static let versatileBundleExtension = """
import class Foundation.Bundle
import class Foundation.ProcessInfo
import struct Foundation.URL

private class BundleFinder {}

extension Bundle {
    public static let package: Bundle = {
        let bundleName = "\(packageName)_\(targetName)"

        let overrides: [URL]
        #if DEBUG
        // The 'PACKAGE_RESOURCE_BUNDLE_PATH' name is preferred since the expected value is a path. The
        // check for 'PACKAGE_RESOURCE_BUNDLE_URL' will be removed when all clients have switched over.
        // This removal is tracked by rdar://107766372.
        if let override = ProcessInfo.processInfo.environment["PACKAGE_RESOURCE_BUNDLE_PATH"]
            ?? ProcessInfo.processInfo.environment["PACKAGE_RESOURCE_BUNDLE_URL"] {
            overrides = [URL(fileURLWithPath: override)]
        } else if let override = ProcessInfo.processInfo.environment["XCTestBundlePath"] {
            // Get the bundle from inside of the testing bundle in case the library had been linked statically
            // and the resource bundle ended up being copies inside the testing bundle
            overrides = [URL(fileURLWithPath: override)]
        } else {
            overrides = []
        }
        #else
        overrides = []
        #endif

        var candidates = overrides + [
            // Bundle should be present here when the package is linked into an App.
            Bundle.main.resourceURL,

            // Bundle should be present here when the package is linked into a framework.
            Bundle(for: BundleFinder.self).resourceURL,

            // For command-line tools.
            Bundle.main.bundleURL
        ]

        // FIX FOR PREVIEWS
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            candidates.append(contentsOf: [
                // Bundle should be present here when running previews from a different package
                Bundle(for: BundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent(),
                Bundle(for: BundleFinder.self).resourceURL?.deletingLastPathComponent().deletingLastPathComponent().deletingLastPathComponent()
            ])
        }

        for candidate in candidates {
            let bundlePath = candidate?.appendingPathComponent(bundleName + ".bundle")
            if let bundle = bundlePath.flatMap(Bundle.init(url:)) {
                return bundle
            }
        }

        fatalError("unable to find bundle named \(packageName)_\(targetName)")
    }()
}
"""
}
