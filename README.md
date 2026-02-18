# MailCover: Effortless Email Composition for SwiftUI Apps

MailCover is a powerful Swift package designed to simplify the process of integrating email composition within your SwiftUI apps using the MessageUI framework. With an intuitive interface, this package enables developers to effortlessly add email composition functionality to their apps without dealing with the complexities of directly working with the framework.

## Supported platforms
- iOS 13+
- macOS 10.15+

## Features
- Compatible with iOS 15, iPadOS 15 and macOS 12 for seamless integration across platforms
- Single-line view modifier for smooth email composition within your app
- Automatic handling of common email composition fields such as message, subject, recipients, ccRecipients, and bccRecipients
- Alerts for email result notifications
- Built-in error handling for easy troubleshooting and enhanced stability

## Benefits
- Streamline your development process by quickly integrating email composition capabilities
- Deliver a consistent and user-friendly email composition experience to your app users
- Reduce the risk of errors and crashes with a robust, tested solution for email composition
- Debug and maintain your app with ease using the provided error handling

## Installation
### Swift Package Manager
To integrate MailCover into your Xcode project, navigate to File -> Add Packages... and enter the following URL:
```
https://github.com/TopScrech/MailCover
```

Alternatively, include it as a dependency in your Package.swift's dependencies value:
```
dependencies: [
    .package(url: "https://github.com/TopScrech/MailCover", .branchItem("main"))
]
```

## Usage
First, import the MailCover library into your project:
```
import MailCover
```

Next, apply the .mailCover() view modifier to any view, using a @State or @Published property to manage the presentation:
```
View {...}
    .mailCover(isPresented: $isShowingMailCover, message: "Take a look on this email!", subject: "Cool Subject", recipients: ["example@icloud.com", "example@mail.nl"], ccRecipients: ["example@mail.com"], bccRecipients: ["example@mail.net"], alerts: .disabled)
```

You can also use the view modifier without any additional parameters (alerts are enabled by default):
```
View {...}
    .mailCover(isPresented: $isShowingMailCover)
```

### Upgrade your app's email composition capabilities effortlessly with MailCover today!
