//
//  AppDelegate.swift
//  Wikia
//
//  Created by BOGU$ on 08/05/2019.
//  Copyright © 2019 lyzkov. All rights reserved.
//

import UIKit
import AlamofireNetworkActivityLogger

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NetworkActivityLogger.shared.startLogging()

        return true
    }

}

