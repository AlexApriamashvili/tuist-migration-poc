import ProjectDescription

let project = Project(
    name: "Migrated-Tuist",
    settings: .settings(configurations: [
        .debug(name: "Debug", xcconfig: "./xcconfigs/Project.xcconfig"), 
        .release(name: "Release", xcconfig: "./xcconfigs/Project.xcconfig"), 
    ]),
    targets: [
        .target(
            name: "App",
            destinations: .iOS,
            product: .app,
            bundleId: "io.safetyculture.tuist-poc",
            infoPlist: .default,
            sources: .sourceFilesList(
                globs: [
                    .glob(
                        "odd-directory-structure-app/**", 
                        excluding: [
                            "odd-directory-structure-app/Assets.xcassets", 
                            "odd-directory-structure-app/Base.lproj/**", 
                            "odd-directory-structure-app/Packages/**",
                            "odd-directory-structure-app/Info.plist"
                        ]),
                ]),
            resources: [
                "odd-directory-structure-app/Assets.xcassets", 
                "odd-directory-structure-app/Base.lproj/**"
            ],
            dependencies: [
                .external(name: "Common")
            ]
        ),
        .target(
            name: "AppTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.safetyculture.tuist-poc.tests",
            infoPlist: .default,
            sources: ["example-test-target/**"],
            resources: [],
            dependencies: [
                .target(name: "App"), 
                .external(name: "Common"),
                .external(name: "CommonTestingSupport"),
            ]
        ),
    ]
)
