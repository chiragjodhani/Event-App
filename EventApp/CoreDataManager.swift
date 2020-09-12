//
//  CoreDataManager.swift
//  EventApp
//
//  Created by Chirag's on 02/09/20.
//  Copyright © 2020 Chatur's. All rights reserved.
//

import Foundation
import UIKit
import CoreData
final class CoreDataManager {
    static let shared = CoreDataManager()
    lazy var persistantContainer: NSPersistentContainer  = {
        let persistantContainer = NSPersistentContainer(name: "EventApp")
        persistantContainer.loadPersistentStores { (_, error) in
            print(error?.localizedDescription ?? "")
        }
        return persistantContainer
    }()
    
    var moc : NSManagedObjectContext  {
        persistantContainer.viewContext
    }
    
    func getEvent<T: NSManagedObject>(_ id: NSManagedObjectID) -> T? {
        do {
            return try moc.existingObject(with: id) as? T
        }catch {
            print(error)
        }
        return nil
    }
    
    func save(){
        do {
            try moc.save()
        }catch {
            print(error)
        }
    }
    
    func getAll<T: NSManagedObject>() -> [T] {
        do {
            let fetchRequest = NSFetchRequest<T>(entityName: "\(T.self)")
            return try moc.fetch(fetchRequest)
        }catch {
            print(error)
            return []
        }
    }
}
