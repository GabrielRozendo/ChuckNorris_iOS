//
//  FactsRepository.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import Foundation
import RxSwift

// MARK: - PROTOCOL

protocol FactsRepositoryProtocol {
    var isReady: BehaviorSubject<Bool> { get }
}

// MARK: - CLASS

class FactsRepository {
    // MARK: - PRIVATE PROPERTIES

    private let service: FactsServiceProtocol

    // MARK: - PUBLIC PROPERTIES

    let isReady = BehaviorSubject<Bool>(value: true)

    // MARK: - INIT

    init(service: FactsServiceProtocol) {
        self.service = service
    }
}

// MARK: - EXTENSIONS

extension FactsRepository: FactsRepositoryProtocol {}
