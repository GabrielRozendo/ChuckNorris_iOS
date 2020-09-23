//
//  FactsService.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import Foundation

// MARK: - PROTOCOL

protocol FactsServiceProtocol {}

// MARK: - CLASS

class FactsService {
    // MARK: - PRIVATE PROPERTIES

    private let networkManager: NetworkManagerProtocol

    // MARK: - INIT

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
}

// MARK: - EXTENSIONS

extension FactsService: FactsServiceProtocol {}
