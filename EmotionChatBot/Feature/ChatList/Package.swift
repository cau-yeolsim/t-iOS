// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChatList",
    products: [
        .library(
            name: "ChatList",
            targets: ["ChatList"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/Quick/Nimble",
            .upToNextMajor(from: "12.0.0")
        ),
        .package(
            url: "https://github.com/Quick/Quick",
            .upToNextMajor(from: "6.0.0")
        ),
        .package(
            url: "https://github.com/ReactiveX/RxSwift",
            .upToNextMajor(from: "6.0.0")
        ),
//        .package(path: "./ChallengeConfirmScene")
    ],
    targets: [
        
        .target(
            name: "ChatList",
            dependencies: [
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxCocoa", package: "RxSwift"),
                .product(name: "RxRelay", package: "RxSwift"),
            ]),
        .testTarget(
            name: "ChatListTests",
            dependencies: [
                "ChatList",
                .product(name: "Nimble", package: "Nimble"),
                .product(name: "Quick", package: "Quick"),
            ]),
    ]
)
