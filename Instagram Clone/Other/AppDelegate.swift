//
//  AppDelegate.swift
//  Instagram Clone
//
//  Created by lindongdong on 2017/9/3.
//  Copyright © 2017年 Ringo Lin. All rights reserved.
//

import UIKit
import Firebase
import FBSDKCoreKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,UNUserNotificationCenterDelegate, MessagingDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //注册以接收远程通知
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
       
        //初始化 Firebase
        FirebaseApp.configure()
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // window根视图控制器
        let tabBarVC = UIStoryboard(name: "TabBar", bundle: nil).instantiateViewController(withIdentifier: "TabBar")
        let  loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login")
        window?.rootViewController = AuthService.isUserLogIn() ? tabBarVC :loginVC
        
        //检索当前注册令牌
        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
        
        return true
  
    }
    
    func application(_ application: UIApplication,didReceiveRemoteNotification notification: [AnyHashable:Any],fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if Auth.auth().canHandleNotification(notification){
            completionHandler(UIBackgroundFetchResult.noData)
        }
        
        // This notification is not auth related, developer should handle it.
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    
        let handled = FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: UIApplicationOpenURLOptionsKey.sourceApplication.rawValue , annotation:UIApplicationOpenURLOptionsKey.annotation.rawValue )
       
        return handled;
    }
    
    func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
    }

   
   

}

