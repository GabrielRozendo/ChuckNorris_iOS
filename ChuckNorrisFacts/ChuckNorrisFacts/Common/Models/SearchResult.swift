//
//  SearchResult.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import Foundation

class SearchResult: Codable {
    let total: Int
    let result: [Fact]

    enum CodingKeys: String, CodingKey {
        case total
        case result
    }
}
