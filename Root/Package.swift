// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Root",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Root",
            type: .dynamic,
            targets: [
                "Root",
                "FoodUI",
            ]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(name: "SwiftUIPreviewLib", path: "../SwiftUIPreviewLib"),
        .package(name: "SwiftUILib", path: "../SwiftUILib"),
        .package(name: "NetworkLib", path: "../NetworkLib"),
        .package(name: "StandartLib", path: "../StandartLib"),
        .package(name: "MVVMLib", path: "../MVVMLib"),
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.8.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Root",
            dependencies: [
                "Settings",
                "FoodUI",
                "FoodAPI",
                "Swinject",
            ],
            resources: []
        ),
        .target(
            name: "FoodUI",
            dependencies: [
                "StandartLib",
                "SwiftUIPreviewLib",
                "SwiftUILib",
                "Localization",
                "FoodAPI",
                "MVVMLib",
                "Swinject",
            ]
        ),
        .target(
            name: "FoodAPI",
            dependencies: [
                "NetworkLib",
                "Swinject",
            ],
            resources: []
        ),
        .target(
            name: "Settings",
            dependencies: [
                "StandartLib",
                "Swinject",
            ],
            resources: []
        ),
        .target(
            name: "Localization",
            dependencies: [
                "SwiftUIPreviewLib",
            ],
            resources: [
                .process("Strings")
            ]
        ),
//        .testTarget(
//            name: "RootTests",
//            dependencies: [
//                "Root"
//            ]),
    ]
)
