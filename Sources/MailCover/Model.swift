#if canImport(MessageUI)

import MessageUI

public enum MailAlertsOptions {
    case enabled,
         disabled
}

struct MailResult: Identifiable, Equatable {
    let id = UUID()
    let result: Result<MFMailComposeResult, Error>
    
    init(_ result: Result<MFMailComposeResult, Error>) {
        self.result = result
    }
    
    static func == (lhs: MailResult, rhs: MailResult) -> Bool {
        lhs.id == rhs.id
    }
}
#endif
