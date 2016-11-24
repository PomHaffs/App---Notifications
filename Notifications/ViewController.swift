//
//  ViewController.swift
//  Notifications
//
//  Created by Tomas-William Haffenden on 23/11/16.
//  Copyright © 2016 PomHaffs. All rights reserved.
//

//Permision needed to us NOTIFICATIONS so need to do the p.list thing

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 1. Request permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
        
            if granted {
                print("notification access granted!")
            } else {
                print(error?.localizedDescription as Any)
            }
        })
    }

//Time Int is where you can control regularity for weekly, daily notifications
    @IBAction func notifyButtonPressed(sender: UIButton) {
        scheduleNotification(inSeconds: 5, completion: { success in
            if success {
                print("Successfully scheduled notifcation")
            } else {
                print("error scheduling notification")
            }
        })
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        
//Add attachment to notifcation SETUP
        let myImage = "rick_grimes"
        guard let imageUrl = Bundle.main.url(forResource: myImage, withExtension: "gif") else {
            completion(false)
            return
        }
        var attachment: UNNotificationAttachment
        attachment = try! UNNotificationAttachment(identifier: "myNotification", url: imageUrl, options: .none)
        
        let notif = UNMutableNotificationContent()
        
        notif.title = "New Notification"
        notif.subtitle = "These are great"
        notif.body = "The new notification options is iOS 10 are what I've always dreamed of!"
//Adding attachement GIF, could have an array and then pick which in here
        notif.attachments = [attachment]
        
        let notifTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notif, trigger: notifTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print(error!)
                completion(false)
            } else {
                completion(true)
            }
        })
    
    }
    
}


































