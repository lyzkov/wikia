// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Wikia",
    products: [],
    dependencies: [
        // add your dependencies here, for example:
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.0.0")),
    ],
    targets: [
        .target(
            name: "Wikia",
            dependencies: [
                // add your dependencies scheme names here, for example:
                "RxSwift",
                "RxCocoa",
            ],
            path: "Wikia"
        ),
    ]
)
