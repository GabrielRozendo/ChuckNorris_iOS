//
//  Source: https://www.youtube.com/watch?v=AoSGcDNmbxo
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import Foundation
import SystemConfiguration

protocol ReachabilityProtocol {
    static var isConnectedToNetwork: Bool { get }
}

final class Reachability: ReachabilityProtocol {
    static var isConnectedToNetwork: Bool {
        var zeroAddress = sockaddr_in(sin_len: 0,
                                      sin_family: 0,
                                      sin_port: 0,
                                      sin_addr: in_addr(s_addr: 0),
                                      sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }

        var flags = SCNetworkReachabilityFlags(rawValue: 0)

        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }

        return isNetworkReachable(with: flags)
    }

    private static func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        let canConnectedAutometicaly = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectedWithoutUserInteraction = canConnectedAutometicaly && !flags.contains(.interventionRequired)
        return isReachable && (!needsConnection || canConnectedWithoutUserInteraction)
    }
}
