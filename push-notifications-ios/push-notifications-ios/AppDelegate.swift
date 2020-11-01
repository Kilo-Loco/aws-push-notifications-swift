//
//  AppDelegate.swift
//  push-notifications-ios
//
//  Created by Kilo Loco on 11/1/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AmplifyService.configure()
        PushNotificationService.shared.registerPushNotification(for: application)
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        PushNotificationService.shared.store(deviceToken)
    }
}

