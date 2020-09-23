//
//  Fact.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

// This file was generated from JSON Schema using quicktype: https://app.quicktype.io/

import CoreData
import Foundation

// MARK: - FACT

struct Fact: Codable {
    // MARK: - PROPERTIES

    private var categoriesRaw: [FactCategory]

    var category: FactCategory {
        return categoriesRaw.first ?? FactCategory.defaultCategory
    }

    let createdAt: Date
    let iconURL: String
    let id: String
    let updatedAt: Date
    let url: String
    let value: String

    // MARK: - INIT

    init(
        categories: [FactCategory],
        createdAt: Date,
        iconURL: String,
        id: String,
        updatedAt: Date,
        url: String,
        value: String) {
        self.categoriesRaw = categories
        self.createdAt = createdAt
        self.iconURL = iconURL
        self.id = id
        self.updatedAt = updatedAt
        self.url = url
        self.value = value
    }

    // MARK: - CODING KEYS

    enum CodingKeys: String, CodingKey {
        case categoriesRaw = "categories"
        case createdAt = "created_at"
        case iconURL = "icon_url"
        case id
        case updatedAt = "updated_at"
        case url
        case value
    }
}
