//
//  AppDelegate.swift
//  Vedanta
//
//  Created by Dishant Rajput on 13/09/22.
//

// com.googleusercontent.apps.332203884683-i7ub3lqqg9bpv4gj67i05ucfv6emnhvu

// FacebookClientToken : 8e04aba20d545838bd7245677e9650af

import UIKit
import Firebase
// import FirebaseCore

import GoogleSignIn
import FBSDKCoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate , MessagingDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FirebaseApp.configure()
        
        // facebook
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // google
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if error != nil || user == nil {
                // Show the app's signed-out state.
                print("app signed out")
            } else {
                // Show the app's signed-in state.
                print("app signed in")
            }
        }
        
        
        
        //        let signInConfig = GIDConfiguration.init(clientID: "667327318779-tkfbdk516uo8reigb3pcen1bsfgbmi6h.apps.googleusercontent.com")
        //        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self)
        
        // google
        // GIDSignIn.sharedInstance.clientID = "995626688633-npat1k40q8mrroia4b3vg5rs4t22pf4o.apps.googleusercontent.com"
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
        } else {
            let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self
        self.fetchDeviceToken()
        
        return true
    }
    
    // MARK:- FIREBASE NOTIFICATION -
    @objc func fetchDeviceToken() {
        
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FCM registration token: \(token)")
                // self.fcmRegTokenMessage.text  = "Remote FCM registration token: \(token)"
                
                let defaults = UserDefaults.standard
                defaults.set("\(token)", forKey: "key_my_device_token")
                
                
            }
        }
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Error = ",error.localizedDescription)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    
    
    
    
    // MARK:- WHEN APP IS OPEN -
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let notification_item = notification.request.content.userInfo
        print(notification_item as Any)
        
        completionHandler([.banner,.badge, .sound])
        
    }
    
    // MARK:- WHEN APP IS IN BACKGROUND - ( after click popup ) -
    @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("User Info = ",response.notification.request.content.userInfo)
        
        let background_notification_item = response.notification.request.content.userInfo
        print(background_notification_item as Any)
        
        
        
    }
    
    
    
    
    
    
    
    
    // MARK: UISceneSession Lifecycle
    
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
    
    func application(
        _ app: UIApplication,
        open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        
        // fb
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
        
        // google
        var handled: Bool
        
        handled = GIDSignIn.sharedInstance.handle(url)
        if handled {
            return true
        }
        
        // Handle other custom URL types.
        
        // If not handled by this app, return false.
        return false
    }
    
    /*func sign(_ signIn: GIDSignIn!,
     didSignInFor user: GIDGoogleUser!,
     withError error: Error!) {
     
     // Check for sign in error
     if let error = error {
     if (error as NSError).code == GIDSignInError.hasNoAuthInKeychain.rawValue {
     print("The user has not signed in before or they have since signed out.")
     } else {
     print("\(error.localizedDescription)")
     }
     return
     }
     
     // Post notification after user successfully sign in
     NotificationCenter.default.post(name: .signInGoogleCompleted, object: nil)
     }*/
    
    /*
     func application(_ app: UIApplication,
     open url: URL,
     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
     
     return GIDSignIn.sharedInstance.handle(url)
     }
     */
    
    /*func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        )
    }*/
    
}


//extension AppDelegate: GIDSignInDelegate {
//    
//    
//}


/*// MARK:- Notification names
 extension Notification.Name {
 
 /// Notification when user successfully sign in using Google
 static var signInGoogleCompleted: Notification.Name {
 return .init(rawValue: #function)
 }
 }*/

/*// MARK: - Custom URL Schemes -
 extension AppDelegate {
 
 func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
 if GIDSignIn.sharedInstance.handle(url) ||
 ApplicationDelegate.shared.application(app, open: url, options: options) {
 return true
 }
 return false
 }
 
 
 func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
 return ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions as? [UIApplication.LaunchOptionsKey : Any])
 }
 }*/

