//
//  NotificationTester.swift
//  NotificationTester
//
//  Created by Shekhar Chauhan on 4/14/24.
//

import SwiftUI
import NotificationCenter

class NotificationManager {
    static let instance = NotificationManager() //singleton
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("ERROR: \(error)")
            }
            else {
                print("SUCCESS")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "This is my first notification"
        content.subtitle = "This was so easy"
        content.body = "Only issue was setting the project as Playground (UIKit) instead of SwiftUI"
        content.sound = .default
        content.badge = 1
        
        //time
        //calendar
        //location
        
        /*
        var dateComponents = DateComponents()
        dateComponents.hour = 19
        dateComponents.minute = 47
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        */
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelNotifications() {
        //UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

struct NotificationTester: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request Permission") {
                NotificationManager.instance.requestAuthorization()
            }
            Button("Schedule Notifications") {
                NotificationManager.instance.scheduleNotification()
            }
            Button("Clear Notifications") {
                NotificationManager.instance.cancelNotifications()
            }
        }
        .onAppear {
            UIApplication.shared.applicationIconBadgeNumber = 1000
        }
    }
}

struct NotificationTester_Previews: PreviewProvider {
    static var previews: some View {
        NotificationTester()
    }
}




