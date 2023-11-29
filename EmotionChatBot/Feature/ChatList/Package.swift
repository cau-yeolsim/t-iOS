// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChatList",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "ChatList",
            targets: ["ChatList"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/ReactiveX/RxSwift",
            .upToNextMajor(from: "6.0.0")
        ),
        .package(
            url: "https://github.com/SnapKit/SnapKit",
            .upToNextMajor(from: "5.0.0")
        ),
        .package(
            url: "https://github.com/RxSwiftCommunity/RxNimble",
            .upToNextMajor(from: "5.0.0")
        ),
        .package(
            url: "https://github.com/onevcat/Kingfisher",
            .upToNextMajor(from: "7.0.0")
        ),
        .package(path: "./Util"),
    ],
    targets: [
        
        .target(
            name: "ChatList",
            dependencies: [
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxCocoa", package: "RxSwift"),
                .product(name: "RxRelay", package: "RxSwift"),
                .product(name: "SnapKit", package: "SnapKit"),
                .product(name: "Kingfisher", package: "Kingfisher"),
                .product(name: "Util", package: "Util"),

            ],
            resources: [.process("Resources")]
        ),
        .testTarget(
            name: "ChatListTests",
            dependencies: [
                "ChatList",
                .product(name: "RxTest", package: "RxSwift"),
                .product(name: "RxBlocking", package: "RxSwift"),
                .product(name: "RxNimble", package: "RxNimble"),
            ]),
    ]
)
