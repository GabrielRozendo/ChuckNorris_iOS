//
//  DataManagerMock.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import Foundation

class DataManagerMock: DataManagerProtocol {
    var categories: [FactCategory]?
    var fact = [Fact]()

    func saveCategories(with categories: [FactCategory]) {
        self.categories = categories
    }

    func getCategories() -> [FactCategory]? {
        return categories
    }
}
