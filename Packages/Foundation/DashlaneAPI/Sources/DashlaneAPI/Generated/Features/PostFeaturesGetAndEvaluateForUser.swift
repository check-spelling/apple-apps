import Foundation
extension UserDeviceAPIClient.Features {
        public struct GetAndEvaluateForUser {
        public static let endpoint: Endpoint = "/features/GetAndEvaluateForUser"

        public let api: UserDeviceAPIClient

                public func callAsFunction(features: [String], timeout: TimeInterval? = nil) async throws -> Response {
            let body = Body(features: features)
            return try await api.post(Self.endpoint, body: body, timeout: timeout)
        }
    }

        public var getAndEvaluateForUser: GetAndEvaluateForUser {
        GetAndEvaluateForUser(api: api)
    }
}

extension UserDeviceAPIClient.Features.GetAndEvaluateForUser {
        struct Body: Encodable {

                public let features: [String]
    }
}

extension UserDeviceAPIClient.Features.GetAndEvaluateForUser {
    public typealias Response = DataType

        public struct DataType: Codable, Equatable {

                public let enabledFeatures: [String]

        public init(enabledFeatures: [String]) {
            self.enabledFeatures = enabledFeatures
        }
    }
}
