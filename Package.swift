// swift-tools-version: 6.2.1
import PackageDescription

let package = Package(
    name: "MailCover",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "MailCover",
            targets: ["MailCover"]
        )
    ],
    targets: [
        .target(
            name: "MailCover",
            linkerSettings: [
                .linkedFramework("MessageUI")
            ]
        )
    ]
)
