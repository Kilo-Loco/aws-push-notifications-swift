//
//  ViewController.swift
//  push-notifications-ios
//
//  Created by Kilo Loco on 11/1/20.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func didTapSendPushNotificationButton() {
        guard let deviceToken = PushNotificationService.shared.deviceToken else { return }
        let notification = Notification(deviceToken: deviceToken)
        AmplifyService.create(notification)
    }

}

