//
//  AppDelegate.swift
//  AFN
//
//  Created by ABS on 16/2/6.
//  Copyright © 2016年 ABS. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        print("finfishLaunchingWithOptions")
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        print("resignActive")
    }

    func applicationDidEnterBackground(application: UIApplication) {
        print("enterBackground")
    }

    func applicationWillEnterForeground(application: UIApplication) {
        print("enterForeground")
    }

    func applicationDidBecomeActive(application: UIApplication) {
        print("beaconActive")
    }

    func applicationWillTerminate(application: UIApplication) {
        print("willTerminate")
    }


}

