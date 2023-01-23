import Foundation

extension UserEvent {

public struct `AutofillAccept`: Encodable, UserEventProtocol {
public static let isPriority = true
public init(`dataTypeList`: [Definition.ItemType], `isProtected`: Bool? = nil, `isSetAsDefault`: Bool? = nil, `itemPosition`: Int? = nil, `webcardOptionSelected`: Definition.WebcardSaveOptions? = nil) {
self.dataTypeList = dataTypeList
self.isProtected = isProtected
self.isSetAsDefault = isSetAsDefault
self.itemPosition = itemPosition
self.webcardOptionSelected = webcardOptionSelected
}
public let dataTypeList: [Definition.ItemType]
public let isProtected: Bool?
public let isSetAsDefault: Bool?
public let itemPosition: Int?
public let name = "autofill_accept"
public let webcardOptionSelected: Definition.WebcardSaveOptions?
}
}
