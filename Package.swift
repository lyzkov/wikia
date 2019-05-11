// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "Wikia",
    products: [],
    dependencies: [
        // add your dependencies here, for example:
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/NoTests/RxFeedback.swift.git", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/RxSwiftCommunity/Action.git", .upToNextMajor(from: "4.0.0")),
    ],
    targets: [
        .target(
            name: "Wikia",
            dependencies: [
                // add your dependencies scheme names here, for example:
                "RxSwift",
                "RxCocoa",
		"RxFeedback",
		"Action",
            ],
            path: "Wikia"
        ),
    ]
)
