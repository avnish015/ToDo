//
//  HomeViewModel.swift
//  ToDo
//
//  Created by Avnish Kumar on 08/07/21.
//

import Foundation
import CoreData

class HomeViewModel {
    private var eventList = [Event]()
    var filteredEventList = Observable([Event]())
    var selectedRow = 0
    var isModifying = false
    
    func updateToDoList() {
        self.eventList = CoreDataManager.shared.fetchAllEvents()
    }
    
    func filterEventListFor(text:String?) {
        guard let text = text else {
             self.filteredEventList.value = self.eventList
            return
        }
        if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            self.filteredEventList.value = self.eventList
        }else {
            self.filteredEventList.value = self.eventList.filter{($0.detail ?? Constant.emptyString).lowercased().contains(text.lowercased())}
        }
    }
    
    func eventForRow(_ row:Int) -> Event {
        filteredEventList.value[row]
    }
    
    func getNumberOfEvents() -> Int {
        filteredEventList.value.count
    }
    
    func deleteEventFor(row:Int) {
        let event = filteredEventList.value[row]
        if event.reminderEnabled {
            ReminderManager.shared.removeUserNotification(event: event)
        }
        CoreDataManager.shared.deleteEvent(event: event)
        self.updateToDoList()
    }
    
    func getEventDateStringFor(row:Int) -> String {
        guard let date = filteredEventList.value[row].date else {
            return Constant.emptyString
        }
        return date.dateInStringFormatFor()
    }
    
    func getEventDetailFor(row:Int) -> String {
        filteredEventList.value[row].detail ?? Constant.emptyString
    }
    
}
