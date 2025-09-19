// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "QYQTexasPlaygroundPackage",
    platforms: [           // ← 添加这一行
            .iOS(.v13),        // ← 指定最低支持 iOS 13.0
            .macOS(.v11)
        ],                     // ← 结束 platforms
    dependencies: [
        .package(url: "https://github.com/apple/swift-certificates.git", from: "1.14.0"),
        .package(url: "https://github.com/apple/swift-crypto.git", from: "3.12.3")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "QYQTexasPlaygroundPackage",
            dependencies: [
                .product(name: "X509", package: "swift-certificates"),
                .product(name: "Crypto", package: "swift-crypto")
            ]),
    ]
)
