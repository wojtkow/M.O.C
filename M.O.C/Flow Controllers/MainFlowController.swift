//
//  MainFlowController.swift
//  M.O.C
//
//  Created by Tomasz Wojtkowiak on 16/05/2019.
//  Copyright © 2019 Peritum.Net. All rights reserved.
//

import Foundation
import UIKit

class MainFlowController: NSObject {
	
	var navigationController: MOCRootNavigationController! {
		didSet {
			topViewController = (navigationController.topViewController as! MapViewController)
			
			setupLoginFlow()
		}
	}
	
	var topViewController: DashboardViewController!
	private var mainFactory: MainFactory
	
	init(withDependencyFactory dependencyFactory: MainFactory) {
		mainFactory = dependencyFactory
	}

}
