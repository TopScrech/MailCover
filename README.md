# MailCover

SwiftUI library for presenting in-app mail sheets

<img width="330" height="717" alt="Screenshot 2026-05-10 at 01 11 07" src="https://github.com/user-attachments/assets/8d88c2df-959e-40d3-a372-f6d0f1715aa2" />

## Supported platforms
- iOS 13+
- macOS 10.15+

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

Apply the .mailCover() view modifier to any view, using a @State or @Published property to manage the presentation:
```
import MailCover

struct ContentView: View {
    @State private var isPresented = false
    
    var body: some View {
        Button("Open Mailer") {
            isPresented = true
        }
        .mailCover(isPresented: $isShowingMailCover)
        
        // You can also customize the prefilled information
        
        .mailCover(
            isPresented: $isShowingMailCover,
            message: "Take a look on this email!",
            subject: "Cool Subject",
            recipients: ["example@icloud.com", "example@mail.nl"],
            ccRecipients: ["example@mail.com"],
            bccRecipients: ["example@mail.net"],
            alerts: .disabled
        )
    }
}
```
