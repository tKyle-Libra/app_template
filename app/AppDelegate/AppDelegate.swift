//
//  AppDelegate.swift
//  JC
//
//  Created by harry on 2019/9/5.
//  Copyright © 2019 harry. All rights reserved.
//

import UIKit
import CocoaLumberjack
import TXLiteAVSDK_Professional
import IQKeyboardManagerSwift
import ImSDK


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        loggerInitialize()
        liveInitialize()
        imInitialize()
        //        keyboardManagerInitialize()
        shareSDKInitialize()
        jpushInitialize()
        #if DEBUG
        JPUSHService.setup(withOption: launchOptions,
                           appKey: "dd017b6985872c5ddd5f23b0",
                           channel: "App Store",
                           apsForProduction: false)
        #else
        JPUSHService.setup(withOption: launchOptions,
                           appKey: "dd017b6985872c5ddd5f23b0",
                           channel: "App Store",
                           apsForProduction: true)
        #endif
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        JPUSHService.registerDeviceToken(deviceToken)
    }
    
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}


fileprivate extension AppDelegate{
    func liveInitialize(){
        let licenceURL = "http://license.vod2.myqcloud.com/license/v1/f9241ed1de2c929a6cbf1b448483815a/TXLiveSDK.licence";
        let licenceKey = "754b79daccc61dc294f76cdd682bbafc";
        TXLiveBase.setLicenceURL(licenceURL, key: licenceKey)
    }
    
    func imInitialize(){
        let sdkConfig = TIMSdkConfig()
        sdkConfig.sdkAppId = 1400263895
        sdkConfig.disableLogPrint = false
        sdkConfig.logLevel = .LOG_DEBUG
        let userConfig = TIMUserConfig()
        TIMManager.sharedInstance()?.initSdk(sdkConfig)
        TIMManager.sharedInstance()?.setUserConfig(userConfig)
    }
    
    func loggerInitialize(){
        DDLog.add(DDTTYLogger.sharedInstance)
    }
    
    func keyboardManagerInitialize(){
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    func shareSDKInitialize(){
        ShareSDK.registPlatforms {
            
            $0?.setupWeChat(withAppId: "wx5042e2b65fe08f26",
                            appSecret: "b7aed67e46caf33b38b4d6675759c7fc",
                            universalLink: "https://www.sandslee.com/")
            
        }
    }
    
    func jpushInitialize(){
        let jpush = JPUSHRegisterEntity()
        if #available(iOS 12.0, *) {
            jpush.types = Int(JPAuthorizationOptions.alert.rawValue |
                JPAuthorizationOptions.badge.rawValue |
                JPAuthorizationOptions.sound.rawValue |
                JPAuthorizationOptions.providesAppNotificationSettings.rawValue)
        } else {
            jpush.types = Int(JPAuthorizationOptions.alert.rawValue |
                JPAuthorizationOptions.badge.rawValue |
                JPAuthorizationOptions.sound.rawValue)
        }
        JPUSHService.register(forRemoteNotificationConfig: jpush, delegate: self)
    }
    
}

extension AppDelegate :JPUSHRegisterDelegate{
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        let userInfo = notification.request.content.userInfo
        if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.classForCoder()))!{
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue))
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo
        if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.classForCoder()))!{
            JPUSHService.handleRemoteNotification(userInfo)
        }
        completionHandler()
    }
    
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification!) {
        
    }
}
