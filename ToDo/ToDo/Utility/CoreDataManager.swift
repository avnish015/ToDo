//
//  CoreDataManager.swift
//  ToDo
//
//  Created by Avnish Kumar on 07/07/21.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    init(){}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ToDo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func fetchAllEvents()->[Event] {
        do {
            let context = CoreDataManager.shared.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<Event>(entityName: "Event")
            var events = try context.fetch(fetchRequest)
            events.sort { (event1, event2) -> Bool in
                if let date1 = event1.date, let date2 = event2.date, date1 > date2{
                    return true
                }
                return false
            }
            return events
        }catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func deleteEvent(event:Event){
        persistentContainer.viewContext.delete(event)
        _ = saveContext()
    }

    // MARK: - Core Data Saving support
    func saveContext () -> Bool{
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
                return false
            }
        }
        return true
    }
    
    
}
