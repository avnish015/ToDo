//
//  ReminderManager.swift
//  ToDo
//
//  Created by Avnish Kumar on 07/07/21.
//

import Foundation
import UserNotifications

class ReminderManager:NSObject {
    static let shared = ReminderManager()
    private let notificationCenter = UNUserNotificationCenter.current()
    
    override private init(){
        super.init()
        notificationCenter.delegate = self
    }
    
    func requestForUserNotification() {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (didAllow, error) in
            if let error = error {
                print("Error:\(error.localizedDescription)")
            }
        }
    }
    
    func setupUserNotifications() {
        notificationCenter.removeAllDeliveredNotifications()
        notificationCenter.removeAllPendingNotificationRequests()
        
        let events = CoreDataManager.shared.fetchAllEvents()
        for event in events {
            if event.reminderEnabled {
                self.addUserNotification(event: event)
            }
        }
        
    }
    
    func addUserNotification(event:Event) {
        guard let date = event.date, let id = event.id, let detail = event.detail else {
            return
        }
        let content = UNMutableNotificationContent()
        content.title = detail
        content.sound = UNNotificationSound.default
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error:\(error.localizedDescription)")
            }
        }
    }
    
    func removeUserNotification(event:Event) {
        guard let id = event.id, event.reminderEnabled == false else{
            return
        }
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [id.uuidString])
        notificationCenter.removeDeliveredNotifications(withIdentifiers: [id.uuidString])
    }
}

extension ReminderManager:UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(UNNotificationPresentationOptions([.sound, .banner, .list]))
    }
    
    
}
