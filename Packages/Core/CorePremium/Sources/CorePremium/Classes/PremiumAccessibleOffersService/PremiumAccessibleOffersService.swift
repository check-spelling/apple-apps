import Foundation
import DashTypes

public final class PremiumAccessibleOffersService {
    
    private enum Endpoint: String {
        case status = "/v1/payments/GetAccessibleStoreOffers"
    }
    
    private enum Key: String {
        case platform
    }
    
    private let apiClient: DeprecatedCustomAPIClient
    
    public init(apiClient: DeprecatedCustomAPIClient) {
        self.apiClient = apiClient
    }
    
    public func getOffers(includeFamilyPlans: Bool = true, preferMonthly: Bool, completion handler: @escaping (Result<Offers, Error>) ->Void) {
        
        struct Params: Encodable {
            let platform: String
        }
        
        let params = Params(platform: Constants.platform.lowercased())
        
        apiClient.sendRequest(to: Endpoint.status.rawValue,
                              using: HTTPMethod.post,
                              input: params,
                              completion: handler)
    }
}
