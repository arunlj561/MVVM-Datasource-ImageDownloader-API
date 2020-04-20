//
//  AppDelegate.swift
//  MVVM+Datasource+ImageDownloader+API
//
//  Created by Arun Jangid on 11/04/20.
//  Copyright © 2020 Arun Jangid. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame:UIScreen.main.bounds)
        
        //uncomment to check with ViewController
        window?.rootViewController = UINavigationController(rootViewController:PhotoViewController())
        
        //uncomment to check with TableViewController
//        window?.rootViewController = UINavigationController(rootViewController:PhotosTableViewController())
        
        window?.makeKeyAndVisible()
        return true
    }

    

}

