//
//  FactCategory.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import CoreData
import Foundation

// MARK: - CATEGORY

typealias FactCategory = String

extension FactCategory {
    static var defaultCategory = "UNCATEGORIZED"
}

// MARK: - CORE DATA

extension FactCategory {
    enum CoreDataFields: String {
        case name
    }

    func setValue(with object: NSManagedObject) {
        object.setValue(self, forKey: CoreDataFields.name.rawValue)
    }

    static func factory(from object: NSManagedObject) -> FactCategory? {
        guard let category = object.value(forKey: CoreDataFields.name.rawValue) as? String
        else { return nil }

        return category
    }
}
