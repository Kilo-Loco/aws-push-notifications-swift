//
//  AmplifyService.swift
//  push-notifications-ios
//
//  Created by Kilo Loco on 11/1/20.
//

import Amplify
import AmplifyPlugins

enum AmplifyService {
    
    static func configure() {
        do {
            try Amplify.add(plugin: AWSAPIPlugin(modelRegistration: AmplifyModels()))
            try Amplify.configure()
            
            print("Configured Amplify successfully!")
        } catch {
            print("Could not configure Amplify", error)
        }
    }
    
    static func create(_ notification: Notification) {
        Amplify.API.mutate(request: .create(notification)) { result in
            do {
                let createdNotification = try result.get().get()
                print("Created", createdNotification)
                
            } catch {
                print("Could not create notification object", error)
            }
        }
    }
}
