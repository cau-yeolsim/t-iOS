// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Util",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Util",
            targets: ["Util"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/ReactiveX/RxSwift",
            .upToNextMajor(from: "6.0.0")
        ),
        .package(
            url: "https://github.com/Alamofire/Alamofire",
            .upToNextMajor(from: "5.0.0")
        ),
    ],
    targets: [
        .target(
            name: "Util",
            dependencies: [
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "RxCocoa", package: "RxSwift"),
                .product(name: "Alamofire", package: "Alamofire")
            ]),
        .testTarget(
            name: "UtilTests",
            dependencies: ["Util"]),
    ]
)
