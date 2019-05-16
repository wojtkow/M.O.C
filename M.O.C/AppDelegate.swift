//
//  AppDelegate.swift
//  M.O.C
//
//  Created by Tomasz Wojtkowiak on 16/05/2019.
//  Copyright © 2019 Peritum.Net. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?
	var mainFactory: MainFactory!

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		mainFactory = MainFactory()
		self.window = mainFactory.mainWindow()
		
		
		IQKeyboardManager.shared.enable = true
		
		self.window?.makeKeyAndVisible()
		return true
	}
}

