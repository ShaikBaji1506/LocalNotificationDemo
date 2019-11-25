//
//  ViewController.swift
//  LocalNotificationDemo
//
//  Created by Shaik Baji on 08/10/19.
//  Copyright © 2019 smartitventures.com. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController,UNUserNotificationCenterDelegate
{

    let myNotification = UNUserNotificationCenter.current() //variable for UNUserNotification
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myNotification.delegate = self
        
        myNotification.requestAuthorization(options:[.alert,.badge,.sound]) { (success, error) in
            print("Success notification received")
            
        }
    }

    @IBAction func notificationTapped(_ sender: UIButton)
    {
        //MARK:- Content
        
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = "My first notification"
        content.badge = 1
        content.sound = UNNotificationSound.default
        content.subtitle = "iOS/Swift"
        content.title = "Local Notification"
        content.body = "Demo Example"
        content.userInfo = ["name":"SHAIK BAJI(iOS Dev)"]
        
        //MARK:- Content Image 
        let  url = Bundle.main.url(forResource:"shaik", withExtension: "jpg")
        let attachment = try! UNNotificationAttachment(identifier: "image", url: url!, options: [:])

        content.attachments = [attachment]
        
        
        //MARK:- Trigger Time
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 3, repeats: false)
        
        let identifier = "Main Identifier"
        
        //MARK:- Request
        let  request = UNNotificationRequest.init(identifier: identifier, content: content, trigger: trigger)
        
        
        //MARK:- Notification Action
        
        let read = UNNotificationAction.init(identifier: "Read Message", title: "Ok", options: UNNotificationActionOptions.foreground)
        let  delete = UNNotificationAction.init(identifier: "Delete Message", title: "Cancel", options: UNNotificationActionOptions.destructive)
        
        let category = UNNotificationCategory.init(identifier:content.categoryIdentifier, actions: [read,delete], intentIdentifiers: [], options: [])
        myNotification.setNotificationCategories([category])
        
        myNotification.add(request) { (error) in
            print("Error == \(error?.localizedDescription)")
        }
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void)
    {
        print("Buddy did receive has been presented")
        if let dict = response.notification.request.content.userInfo as? [String:Any] //[AnyHashable:Any]
        {
            print("Data == \(dict["name"] as! String)")
            print("Pass data to perspective VC")
        }
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert,.badge,.sound])
        print("I got notification")
        
    }
    
}

