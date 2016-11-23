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

    @IBAction func notifyButtonPressed(sender: UIButton) {
        
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        
        let notif = UNMutableNotificationContent()
        
        notif.title = "New Notification"
        notif.subtitle = "These are great"
        notif.body = "The new notification options is iOS 10 are what I've always dreamed of!"
        
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


































