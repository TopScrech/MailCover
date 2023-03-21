// swift-tools-version: 5.7.1
import PackageDescription

let package = Package(
    name: "MailCover",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "MailCover",
            targets: ["MailCover"]),
    ],
    targets: [
        .target(
            name: "MailCover",
            dependencies: [],
            linkerSettings: [
                .linkedFramework("MessageUI")
            ]
        )
    ]
)
