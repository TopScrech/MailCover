import SwiftUI
import MessageUI

@available(iOS 15.0, macOS 12.0, *)
struct MailSheet: ViewModifier {
    @Binding var isPresented: Bool
    
    var message, subject: String?
    var recipients, ccRecipients, bccRecipients: [String]?
    var alerts: MailAlertsOptions
    
    init(_ isPresented: Binding<Bool>,
         message: String? = nil,
         subject: String? = nil,
         recipients: [String]? = nil,
         ccRecipients: [String]? = nil,
         bccRecipients: [String]? = nil,
         alerts: MailAlertsOptions
    ) {
        _isPresented = isPresented
        self.message = message
        self.subject = subject
        self.recipients = recipients
        self.ccRecipients = ccRecipients
        self.bccRecipients = bccRecipients
        self.alerts = alerts
    }
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented) {
                MailView(
                    $isPresented,
                    message: message,
                    subject: subject,
                    recipients: recipients,
                    ccRecipients: ccRecipients,
                    bccRecipients: bccRecipients,
                    alerts: alerts
                )
            }
    }
}

@available(iOS 15.0, macOS 12.0, *)
public extension View {
    func mailCover(
        _ isPresented: Binding<Bool>,
        message: String? = nil,
        subject: String? = nil,
        recipients: [String]? = nil,
        ccRecipients: [String]? = nil,
        bccRecipients: [String]? = nil,
        alerts: MailAlertsOptions = .enabled
    ) -> some View {
        self.modifier(
            MailSheet(
                isPresented,
                message: message,
                subject: subject,
                recipients: recipients,
                ccRecipients: ccRecipients,
                bccRecipients: bccRecipients,
                alerts: alerts
            )
        )
    }
}

@available(iOS 15.0, macOS 12.0, *)
struct MailView: View {
    @Binding var isPresented: Bool
    
    @State private var mailResult: MailResult?
    @State private var alertPresented: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    var message, subject: String?
    var recipients, ccRecipients, bccRecipients: [String]?
    var alerts: MailAlertsOptions = .enabled
    
    init(_ isPresented: Binding<Bool>,
         message: String? = nil,
         subject: String? = nil,
         recipients: [String]? = nil,
         ccRecipients: [String]? = nil,
         bccRecipients: [String]? = nil,
         alerts: MailAlertsOptions
    ) {
        _isPresented = isPresented
        self.message = message
        self.subject = subject
        self.recipients = recipients
        self.ccRecipients = ccRecipients
        self.bccRecipients = bccRecipients
        self.alerts = alerts
    }
    
    var body: some View {
        if MFMailComposeViewController.canSendMail() {
            MailPresenter(result: $mailResult, message: message, subject: subject, recipients: recipients, ccRecipients: ccRecipients, bccRecipients: bccRecipients)
                .onChange(of: mailResult) { result in
                    guard let result = result else {
                        isPresented = false
                        return
                    }
                    switch alerts {
                    case .enabled:
                        switch result.result {
                        case .success(let mailComposeResult):
                            switch mailComposeResult {
                            case .sent:
                                alertTitle = "Success"
                                alertMessage = "Email sent"
                                
                            case .saved:
                                alertTitle = "Cancelled"
                                alertMessage = "Draft saved"
                                
                            case .cancelled:
                                alertTitle = "Cancelled"
                                alertMessage = "Email not sent"
                                
                            case .failed:
                                alertTitle = "Error"
                                alertMessage = "Email failed to send"
                                
                            @unknown default:
                                alertTitle = "Unknown Error"
                                alertMessage = "An unknown error occurred"
                            }
                        case .failure:
                            alertTitle = "Error"
                            alertMessage = "Failed to send email"
                        }
                        alertPresented = true
                        
                    case .disabled:
                        isPresented = false
                    }
                }
                .alert(alertTitle, isPresented: $alertPresented) {
                    Button("OK") { isPresented = false }
                } message: {
                    Text(alertMessage)
                }
        } else {
            VStack {
                Text("Error")
                    .font(.title)
                Text("No email account is set up. Please set up an email account in your device settings.")
                    .multilineTextAlignment(.center)
                    .padding()
                Button(action: {
                    isPresented = false
                }) {
                    Text("OK")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
        }
    }
}

@available(iOS 13.0, macOS 10.15, *)
struct MailPresenter: UIViewControllerRepresentable {
    @Binding var result: MailResult?
    
    var message, subject: String?
    var recipients, ccRecipients, bccRecipients: [String]?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailViewController = MFMailComposeViewController()
        mailViewController.mailComposeDelegate = context.coordinator
        
        if let message {
            mailViewController.setMessageBody(message, isHTML: false)
        }
        
        if let subject {
            mailViewController.setSubject(subject)
        }
        
        if let recipients {
            mailViewController.setToRecipients(recipients)
        }
        
        if let ccRecipients {
            mailViewController.setCcRecipients(ccRecipients)
        }
        
        if let bccRecipients {
            mailViewController.setBccRecipients(bccRecipients)
        }
        
        return mailViewController
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let parent: MailPresenter
        
        init(_ parent: MailPresenter) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            guard error == nil else {
                parent.result = MailResult(result: .failure(error!))
                return
            }
            parent.result = MailResult(result: .success(result))
        }
    }
}
