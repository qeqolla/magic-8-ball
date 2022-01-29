//
//  Network.swift
//  eigth-ball
//
//  Created by Andriy Kmit on 29.01.2022.
//

import Foundation
import SystemConfiguration

class Network: ObservableObject {
    let reachability = SCNetworkReachabilityCreateWithName(nil, "www.apple.com")
    
    func getAnswer() async throws -> String? {
        guard let url = URL(string: "https://8ball.delegator.com/magic/JSON/_") else { return nil }
        let request = URLRequest(url: url)
        let response: (data: Data, response: URLResponse) = try await URLSession.shared.data(for: request)

        let model = try JSONDecoder().decode(Answer.self, from: response.data)
            
        return model.magic.answer
    }
    
    func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectAutomaticly = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithputinteraction = canConnectAutomaticly && !flags.contains(.interventionRequired)
        
        return isReachable && (!needsConnection || canConnectWithputinteraction)
    }

}

