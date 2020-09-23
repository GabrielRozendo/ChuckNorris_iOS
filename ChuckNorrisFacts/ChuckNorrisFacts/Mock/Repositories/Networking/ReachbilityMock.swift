//
//  ReachbilityMock.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import Foundation

class ReachabilityMockWithInternet: ReachabilityProtocol {
    static var isConnectedToNetwork: Bool {
        return true
    }
}

class ReachabilityMockNoInternet: ReachabilityProtocol {
    static var isConnectedToNetwork: Bool {
        return false
    }
}
