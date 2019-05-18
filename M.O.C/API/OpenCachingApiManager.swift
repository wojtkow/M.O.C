//
//  OpenCachingApiManager.swift
//  M.O.C
//
//  Created by Tomasz Wojtkowiak on 18/05/2019.
//  Copyright © 2019 Peritum.Net. All rights reserved.
//

import Foundation
import Alamofire

class OpenCachingApiManager {

	static let shared: OpenCachingApiManager = OpenCachingApiManager()
	
	private let sessionManager: SessionManager
	
	private init() {
		self.sessionManager = SessionManager()
	}
	
	
}
