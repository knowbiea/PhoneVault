//
//  DataController.swift
//  SocialApp
//
//  Created by Arvind on 18/04/25.
//

import Foundation
import CoreData

class DataController {
    let persistentContainer: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    init(modelName: String) {
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError(error?.localizedDescription ?? "")
            }

            completion?()
        }
    }
    
    func save() {
        do {
            try viewContext.save()
            
        } catch {
            print("Save Error: \(error)")
            
        }
    }
}
