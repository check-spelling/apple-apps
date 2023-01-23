import Foundation
import DashTypes

extension EmailInfo {
    init(_ metadata: SharingMetadata) {
        self.init(name: metadata.title, type: .init(metadata.type))
    }
}

extension EmailInfo.`Type` {
    init(_ type: SharingType) {
        switch type {
        case .note:
            self = .note
        case .password:
            self = .password
        }
    }
}
