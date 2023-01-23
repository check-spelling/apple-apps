import Foundation
import DashlaneAppKit

struct DisableReactivationHandler: MaverickOrderHandleable {

    typealias Request = MaverickEmptyRequest
    typealias Response = MaverickEmptyResponse

    let maverickOrderMessage: MaverickOrderMessage
    let settings: AppSettings

    func performOrder() throws -> Response? {
        settings.safariWebCardActivated = false
        return nil
    }
}
