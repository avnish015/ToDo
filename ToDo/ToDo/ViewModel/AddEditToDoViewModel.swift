//
//  AddEditToDoViewModel.swift
//  ToDo
//
//  Created by Avnish Kumar on 08/07/21.
//

import Foundation

class AddEditToDoViewModel {
    var isModifying = false
    var currentEvent:Event?
    var selectedDate:Date?
    var isReminderEnabled = false
    var detailText:String = Constant.emptyString
    var dateText:String {
        if let date = selectedDate {
            return date.dateInStringFormatFor()
        }else {
            return Constant.emptyString
        }
    }
    var isDetailsValid = Observable(true)
    
    func loadData() {
        if let event = self.currentEvent, let date = event.date, let detail = event.detail, isModifying {
            detailText = detail
            selectedDate = date
            isReminderEnabled = event.reminderEnabled
        }
    }
    
    func addUpdateToDo(){
        if  selectedDate != nil, detailText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty == false {
            if let event = self.currentEvent, isModifying {
                saveToDo(event: event)
            }else {
                let context = CoreDataManager.shared.persistentContainer.viewContext
                let event = Event(context: context)
                saveToDo(event: event)
            }
            isDetailsValid.value = true
        }else {
            isDetailsValid.value = false
        }
    }
    
    func saveToDo(event:Event) {
        if !isModifying {
            event.id = UUID()
        }
        event.detail = detailText
        event.date = selectedDate
        event.reminderEnabled = isReminderEnabled
        if CoreDataManager.shared.saveContext() {
            if isModifying {
                ReminderManager.shared.removeUserNotification(event: event)
            }
            if event.reminderEnabled {
                ReminderManager.shared.addUserNotification(event: event)
            }
        }

    }
}
