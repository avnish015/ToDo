//
//  Event+CoreDataProperties.swift
//  ToDo
//
//  Created by Avnish Kumar on 07/07/21.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var date: Date?
    @NSManaged public var detail: String?
    @NSManaged public var reminderEnabled: Bool
    @NSManaged public var id: UUID?

}

extension Event : Identifiable {

}
