// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let headersSearchPath: [CSetting] = [.headerSearchPath("."),
                                     .headerSearchPath("Base"),
                                     .headerSearchPath("Debug"),
                                     .headerSearchPath("Details"),
                                     .headerSearchPath("Details/Transactions"),
                                     .headerSearchPath("Layout"),
                                     .headerSearchPath("Private"),
                                     .headerSearchPath("Private/Layout"),
                                     .headerSearchPath("TextExperiment/Component"),
                                     .headerSearchPath("TextExperiment/String"),
                                     .headerSearchPath("TextExperiment/Utility"),
                                     .headerSearchPath("TextKit"),
                                     .headerSearchPath("tvOS")]

let sharedDefines: [CSetting] = [
                                // always disabled
                                .define("IG_LIST_COLLECTION_VIEW", to: "0"),
                                .define("AS_USE_VIDEO", to: "1"),
                                .define("AS_USE_MAPKIT", to: "1"),
                                .define("AS_USE_PHOTOS", to: "1"),
                                .define("AS_USE_VIDEO", to: "1"),
                                .define("SWIFT_PACKAGE", to: "1"),
                                .define("AS_PIN_REMOTE_IMAGE", to: "1")
                                ]

func IGListKit(enabled: Bool) -> [CSetting] {
  let state: String = enabled ? "1" : "0"
  return [
    .define("AS_IG_LIST_KIT", to: state),
    .define("AS_IG_LIST_DIFF_KIT", to: state),
  ]
}

let package = Package(
    name: "Texture",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AsyncDisplayKit",
            type: .static,
            targets: ["AsyncDisplayKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pinterest/PINRemoteImage.git", .upToNextMajor(from: "3.0.4")),
        .package(url: "https://github.com/pinterest/PINCache.git", .upToNextMajor(from: "3.0.4")),
        .package(url: "https://github.com/pinterest/PINOperation.git", .upToNextMajor(from: "1.2.3")),
        .package(url: "https://github.com/baveku/IGListKitSPM.git", .branch("spm")),
    ],
    targets: [
        .target(
            name: "AsyncDisplayKit",
            dependencies: [.product(name: "IGListKit", package: "IGListKitSPM"), "PINRemoteImage", "PINCache", "PINOperation"],
            path: "Source",
            cSettings: headersSearchPath + sharedDefines + IGListKit(enabled: true)
        ),
    ],
    cLanguageStandard: .c11,
    cxxLanguageStandard: .cxx11
)
