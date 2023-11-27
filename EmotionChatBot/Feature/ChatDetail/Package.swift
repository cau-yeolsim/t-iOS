// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ChatDetail",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ChatDetail",
            targets: ["ChatDetail"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
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

        // chatList 추가
        .package(path: "./ChatList"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ChatDetail",
            dependencies: [
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxCocoa", package: "RxSwift"),
                .product(name: "RxRelay", package: "RxSwift"),
                .product(name: "SnapKit", package: "SnapKit"),
                .product(name: "Kingfisher", package: "Kingfisher"),
                .product(name: "Util", package: "Util"),
                .product(name: "ChatList", package: "ChatList")
            ]),
        .testTarget(
            name: "ChatDetailTests",
            dependencies: [
                "ChatDetail",
                .product(name: "RxTest", package: "RxSwift"),
                .product(name: "RxBlocking", package: "RxSwift"),
                .product(name: "RxNimble", package: "RxNimble"),
            ]),
    ]
)
