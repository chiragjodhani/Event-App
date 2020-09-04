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
    
    func saveEvent(name: String, date: Date, image: UIImage) {
        let event = Event(context: moc)
        event.setValue(name, forKey: "name")
        
        let resizeImage = image.sameAspectRatio(newHeight: 250)
        let imageData = resizeImage.jpegData(compressionQuality: 0.5)
        event.setValue(imageData, forKey: "image")
        event.setValue(date, forKey: "date")
        
        
        do {
            try moc.save()
        }catch {
            print(error)
        }
    }
    
    func fetchEvent() -> [Event] {
        do {
            let fetchRequest = NSFetchRequest<Event>(entityName: "Event")
            let events = try moc.fetch(fetchRequest)
            return events
        }catch {
            print(error)
            return []
        }
    }
}
