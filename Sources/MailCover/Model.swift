import MessageUI

public enum MailAlertsOptions {
    case enabled
    case disabled
}

struct MailResult: Identifiable, Equatable {
    let id = UUID()
    let result: Result<MFMailComposeResult, Error>
    
    static func == (lhs: MailResult, rhs: MailResult) -> Bool {
        return lhs.id == rhs.id
    }
}
