//
//  AuthNotification.swift
//  Skedul
//
//  Created by skedul on 04/11/24.
//

import SwiftUI
import UserNotifications

class NotificationDelegate: NSObject, ObservableObject, UNUserNotificationCenterDelegate {
    @Published var alert = false

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.badge, .banner, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "REPLY" {
            print("Reply button pressed. Details: \(response.notification.request.content.userInfo)")
            self.alert.toggle()
        }
        completionHandler()
    }
}


enum NotificationType {
    case loginWithGoogle
    case loginWithEmail
    case accountCreated
    
    var title: String {
        switch self {
        case .loginWithGoogle: return "Login Successful"
        case .loginWithEmail: return "Login Successful"
        case .accountCreated: return "Account Created"
        }
    }
    
    var subtitle: String {
        switch self {
        case .loginWithGoogle: return "You've logged in with Google"
        case .loginWithEmail: return "You've logged in with Email"
        case .accountCreated: return "Your account successfully created"
        }
    }
}


func createNotification(for type: NotificationType) {
    let content = UNMutableNotificationContent()
    content.title = type.title
    content.subtitle = type.subtitle
    content.categoryIdentifier = "ACTIONS"
    
    content.sound = ShortSound.customSound

    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

    let closeAction = UNNotificationAction(identifier: "CLOSE", title: "Close", options: .destructive)
    let replyAction = UNNotificationAction(identifier: "REPLY", title: "See Detail", options: .foreground)

    let category = UNNotificationCategory(identifier: "ACTIONS", actions: [closeAction, replyAction], intentIdentifiers: [], options: [])

    UNUserNotificationCenter.current().setNotificationCategories([category])
    UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
}
