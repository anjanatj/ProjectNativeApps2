//
//  AppDelegate.swift
//  ProjectNativeApps2
//
//  Created by Anjana T'Jampens on 5/01/18.
//  Copyright © 2018 Anjana T'Jampens. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        return true
    }
    
}

