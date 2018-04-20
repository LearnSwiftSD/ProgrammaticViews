//
//  AppDelegate.swift
//  LearnSwiftProgramaticViews
//
//  Created by Stephen Martinez on 4/18/18.
//  Copyright © 2018 Stephen Martinez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    ///Your app's visual entry point. The top level view in the view heirarchy.
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        AppDelegate.addNavigationControllerTo(&window, with: MyViewController())
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

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    
    /**
     This Static Method produces an entry point for our app without the use
     of a StoryBoard. It Creates a UINavigation Controller and assigns it as
     the root controller for the Window. It also builds a UIViewController
     and assigns it as the root ViewController for the Navigation Controller
     
     - Parameters:
        - window: The Window defined in app delegate that we want to attached to.
        - rootVC: The root view controller assigned to the Navigation Controller
     - Returns: Void
     */
    private static func addNavigationControllerTo(_ window: inout UIWindow?, with rootVC: UIViewController){
        //Get the Device's Screen Size
        let deviceScreenSize = UIScreen.main.bounds
        //Initialize and set the Window
        window = UIWindow(frame: deviceScreenSize)
        //Create the Navigation Controller with the rootVC
        let rootNavController = UINavigationController(rootViewController: rootVC)
        //Hide the Navigation Bar
        rootNavController.navigationBar.isHidden = true
        //Assign the Window's root view controller
        window?.rootViewController = rootNavController
        //Make it visible
        window?.makeKeyAndVisible()
    }
    
    

}

