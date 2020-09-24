//
//  DataManager.swift
//  ChuckNorrisFacts
//
//  Created by Gabriel Oliveira Rozendo on 23/09/20.
//  Copyright © 2020 Gabriel Oliveira Rozendo. All rights reserved.
//

import CoreData

class DataManager {
    // MARK: - PRIVATE PROPERTIES

    internal enum Entities: String {
        case categories = "CategoriesEntity"
        case pastSearches = "PastSearchesEntity"
    }

    // MARK: - CORE DATA

    private func deleteObjects(entity: Entities) throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity.rawValue)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        try context.execute(deleteRequest)
    }

    private lazy var context: NSManagedObjectContext = { persistentContainer.viewContext }()

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ChuckNorrisFacts")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension DataManager: DataManagerProtocol {
    // MARK: - CATEGORIES METHODS

    func saveCategories(with categories: [FactCategory]) {
        guard let categoryEntity = NSEntityDescription.entity(forEntityName: Entities.categories.rawValue, in: context)
        else { return }

        do {
            try deleteObjects(entity: .categories)
        } catch {
            debugPrint(error)
            return
        }

        categories.forEach { category in
            let categoryObject = NSManagedObject(entity: categoryEntity, insertInto: context)
            category.setValue(with: categoryObject)
        }

        saveContext()
    }

    func getCategories() -> [FactCategory]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entities.categories.rawValue)

        do {
            let result = try context.fetch(fetchRequest)
            guard let managedObjects = result as? [NSManagedObject] else { return nil }
            let categories = managedObjects.compactMap { FactCategory.factory(from: $0) }
            return categories.compactMap { $0 }
        } catch {
            debugPrint(error)
            return nil
        }
    }

    // MARK: - PAST SEARCHES METHODS

    func getPastSearchObject(with term: String) -> NSManagedObject? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Entities.pastSearches.rawValue)
        fetchRequest.predicate = NSPredicate(format: "%s = %s", PastSearch.CoreDataFields.term.rawValue, term)

        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            debugPrint("error executing fetch request: \(error)")
        }

        return nil
    }

    func savePastSearch(with pastSearch: PastSearch) {
        guard let pastSearchEntity = NSEntityDescription.entity(forEntityName: Entities.pastSearches.rawValue,
                                                                in: context)
        else { return }

        let object = NSManagedObject(entity: pastSearchEntity, insertInto: context)
        pastSearch.setValue(with: object)

        saveContext()
    }

    func getPastSearch() -> [PastSearch]? {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entities.pastSearches.rawValue)

        do {
            let result = try context.fetch(fetchRequest)
            guard let managedObjects = result as? [NSManagedObject] else { return nil }

            let pastSearch = managedObjects.compactMap { PastSearch.factory(from: $0) }
            return pastSearch.compactMap { $0 }
        } catch {
            debugPrint(error)
            return nil
        }
    }
}
