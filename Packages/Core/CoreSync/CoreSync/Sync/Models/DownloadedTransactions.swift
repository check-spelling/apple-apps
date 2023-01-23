import Foundation
import DashTypes

public struct DownloadedTransactions: Decodable {
    private enum CodingKeys: String, CodingKey {
        case transactions
        case syncAllowed
        case fullBackup
        case timestamp
        case sharingInfo = "sharing2"
        case keys
        case summary
    }

    let transactions: [DownloadedTransaction]
    let syncAllowed: Bool?
    let fullBackup: FullBackup?
    public let timestamp: Timestamp
    let sharingInfo: SharingSummaryInfo?
    let keys: RawSharingKeys?
    let summary: TransactionTimestampSummary?
}
