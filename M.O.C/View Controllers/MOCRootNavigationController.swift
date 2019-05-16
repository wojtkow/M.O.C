//
//  MOCRootNavigationController.swift
//  M.O.C
//
//  Created by Tomasz Wojtkowiak on 16/05/2019.
//  Copyright © 2019 Peritum.Net. All rights reserved.
//

import Foundation
import UIKit

class MOCRootNavigationController: UINavigationController {
	
	var mainFactory: MainFactory
	var flowController: MainFlowController?
	
	init(withDependencyFactory dependencyFactory: MainFactory) {
		self.mainFactory = dependencyFactory
		super.init(nibName: nil, bundle: nil)
		self.viewControllers = [mainFactory.dashboardViewController()]
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init?(coder:) is not supported")
	}
	
}
