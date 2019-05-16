//
//  MainFactory.swift
//  M.O.C
//
//  Created by Tomasz Wojtkowiak on 16/05/2019.
//  Copyright © 2019 Peritum.Net. All rights reserved.
//

import Foundation
import FieryCrucible
import UIKit

class MainFactory : DependencyFactory {
	func mainWindow() -> UIWindow {
		return shared(
			factory: {
				let instance = UIWindow(frame: UIScreen.main.bounds)
				instance.backgroundColor = .white
				return instance
		},
			configure: { instance in
				instance.rootViewController = self.rootViewController()
		}
		)
	}
	
	func rootViewController() -> MOCRootNavigationController {
		return shared(
			factory: {
				let instance = MOCRootNavigationController(withDependencyFactory: self)
				return instance
		},
			configure: { instance in
				instance.flowController = self.mainFlowController()
		}
		)
	}
	
	//MARK: - View Controllers
	
}

