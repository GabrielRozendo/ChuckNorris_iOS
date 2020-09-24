//
//  DataManagerProtocol.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

protocol DataManagerProtocol {
    func saveCategories(with categories: [FactCategory])
    func getCategories() -> [FactCategory]?
}
