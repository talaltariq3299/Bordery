//
//  AppDelegate.swift
//  Bordery
//
//  Created by Kevin Laminto on 1/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
//        if launchedBefore  {
//            print("launch before")
//            // launch before
////            let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
////            let navigationController = UINavigationController.init(rootViewController: storyboard.instantiateViewController(withIdentifier: "PhotoLibraryView"))
////            self.window = UIWindow(frame: UIScreen.main.bounds)
////            self.window?.rootViewController = navigationController
////            self.window?.makeKeyAndVisible()
//
//
//
//        }
//        else {
//            print("new launch")
//            // new launch
//            UserDefaults.standard.set(true, forKey: "launchedBefore")
//        }
        
        
        return true
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


}

