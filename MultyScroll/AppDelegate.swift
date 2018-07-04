//
//  AppDelegate.swift
//  MultyScroll
//
//  Created by Micky on 02/07/2018.
//  Copyright © 2018 Micky. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController(nibName: nil, bundle: nil)
        window?.makeKeyAndVisible()
        
        return true
    }

}

