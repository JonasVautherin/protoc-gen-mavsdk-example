// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "ExampleLibrary",
    products: [
        .library(name: "ExampleLibrary", targets: ["ExampleLibrary"]),
    ],
    targets: [
        .target(
            name: "ExampleLibrary",
            dependencies: ["ExampleLibraryObjC"],
            path: "Sources/ExampleLibrary"
        ),
        .target(
            name: "ExampleLibraryObjC",
            dependencies: ["example_library"],
            path: "Sources/ExampleLibraryObjC"
        ),
        .binaryTarget(
            name: "example_library",
            path: "../../cpp/build/example_library.xcframework"
        ),
    ],
    cxxLanguageStandard: .cxx17
)
