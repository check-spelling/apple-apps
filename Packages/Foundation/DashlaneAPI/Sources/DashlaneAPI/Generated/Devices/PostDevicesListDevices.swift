import Foundation
extension UserDeviceAPIClient.Devices {
        public struct ListDevices {
        public static let endpoint: Endpoint = "/devices/ListDevices"

        public let api: UserDeviceAPIClient

                public func callAsFunction(timeout: TimeInterval? = nil) async throws -> Response {
            let body = Body()
            return try await api.post(Self.endpoint, body: body, timeout: timeout)
        }
    }

        public var listDevices: ListDevices {
        ListDevices(api: api)
    }
}

extension UserDeviceAPIClient.Devices.ListDevices {
        struct Body: Encodable {
    }
}

extension UserDeviceAPIClient.Devices.ListDevices {
    public typealias Response = DataType

        public struct DataType: Codable, Equatable {

        public let pairingGroups: [PairingGroups]

        public let devices: [Devices]

                public struct PairingGroups: Codable, Equatable {

            public let pairingGroupUUID: String

            public let devices: [String]

                        public let name: String?

                        public let platform: String?

            public let isBucketOwner: Bool?

            public init(pairingGroupUUID: String, devices: [String], name: String?, platform: String?, isBucketOwner: Bool? = nil) {
                self.pairingGroupUUID = pairingGroupUUID
                self.devices = devices
                self.name = name
                self.platform = platform
                self.isBucketOwner = isBucketOwner
            }
        }

                public struct Devices: Codable, Equatable {

            public let deviceId: String

            public let deviceName: String?

            public let devicePlatform: String?

            public let creationDateUnix: Int

            public let lastUpdateDateUnix: Int

            public let lastActivityDateUnix: Int

            public let temporary: Bool

                        public let isBucketOwner: Bool?

            public init(deviceId: String, deviceName: String?, devicePlatform: String?, creationDateUnix: Int, lastUpdateDateUnix: Int, lastActivityDateUnix: Int, temporary: Bool, isBucketOwner: Bool? = nil) {
                self.deviceId = deviceId
                self.deviceName = deviceName
                self.devicePlatform = devicePlatform
                self.creationDateUnix = creationDateUnix
                self.lastUpdateDateUnix = lastUpdateDateUnix
                self.lastActivityDateUnix = lastActivityDateUnix
                self.temporary = temporary
                self.isBucketOwner = isBucketOwner
            }
        }

        public init(pairingGroups: [PairingGroups], devices: [Devices]) {
            self.pairingGroups = pairingGroups
            self.devices = devices
        }
    }
}
