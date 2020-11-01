//
//  PushNotificationService.swift
//  push-notifications-ios
//
//  Created by Kilo Loco on 11/1/20.
//

import UIKit
import UserNotifications

class PushNotificationService: NSObject, UNUserNotificationCenterDelegate {
    
    private(set) var deviceToken: String?
    var notificationCenter: UNUserNotificationCenter { .current() }
    
    static let shared = PushNotificationService()
    private override init() {
        super.init()
    }
    
    func registerPushNotification(for application: UIApplication) {
        notificationCenter.delegate = self
        notificationCenter.requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { [weak self] (granted, error) in
            if let unwrappedError = error {
                print("could not authorize notifications", unwrappedError)
            }
            
            guard granted else { return }
            self?.getNotificationSettings(for: application)
        }
    }
    
    private func getNotificationSettings(for application: UIApplication) {
        notificationCenter.getNotificationSettings { settings in
            print("Notification settings:", settings)
            guard settings.authorizationStatus == .authorized else { return }
            
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
    }
    
    func store(_ deviceToken: Data) {
        let stringToken = deviceToken.reduce("") { $0 + String(format: "%02X", $1) }
        print("Retrieved Device Token:", stringToken)
        self.deviceToken = stringToken
    }
    
    // Foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Foreground notification:", notification.request.content.userInfo)
        completionHandler([.banner, .sound])
    }
    
    // Background
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Background notification:", response.notification.request.content.userInfo)
        completionHandler()
    }
    
}
