//
//  StudyLevel_App.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/15.
//

import SwiftUI
import Firebase
import PartialSheet
import FirebaseMessaging
import UserNotifications
import GoogleMobileAds

@main
struct StudyLevel_App: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    let sheetManager: PartialSheetManager = PartialSheetManager()
    let levelUpViewModel = LevelUpViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(sheetManager)
                .environmentObject(levelUpViewModel)
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate {
        
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        Messaging.messaging().delegate = self
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.delegate = self

            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            center.requestAuthorization(options: authOptions) { granted, error in
                guard granted else { return }
            
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                }
            }
       } else {
           let settings: UIUserNotificationSettings =
               UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
           application.registerUserNotificationSettings(settings)
       }

        application.registerForRemoteNotifications()
        
        return true
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        DeviceRegister().register(token: fcmToken)
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
       // Called when a new scene session is being created.
       // Use this method to select a configuration to create the new scene with.
       return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
   }

   func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
       // Called when the user discards a scene session.
       // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
       // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
   }

   func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
       // Print message ID.
       if let messageID = userInfo["gcm.message_id"] {
           print("Message ID: \(messageID)")
       }

       // Print full message.
       print(userInfo)
   }

   func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                    fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
       // Print message ID.
       if let messageID = userInfo["gcm.message_id"] {
           print("Message ID: \(messageID)")
       }

       // Print full message.
       print(userInfo)

       completionHandler(UIBackgroundFetchResult.newData)
   }
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
   func userNotificationCenter(_ center: UNUserNotificationCenter,
                               willPresent notification: UNNotification,
                               withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
       let userInfo = notification.request.content.userInfo

       if let messageID = userInfo["gcm.message_id"] {
           print("Message ID: \(messageID)")
       }

        print(userInfo)

        completionHandler([.list, .banner, .sound, .badge])
   }

   func userNotificationCenter(_ center: UNUserNotificationCenter,
                               didReceive response: UNNotificationResponse,
                               withCompletionHandler completionHandler: @escaping () -> Void) {
       let userInfo = response.notification.request.content.userInfo
       if let messageID = userInfo["gcm.message_id"] {
           print("Message ID: \(messageID)")
       }

       print(userInfo)

       completionHandler()
   }
}

extension Color {
    static let backgroundGray = Color("backgroundGray")
}
