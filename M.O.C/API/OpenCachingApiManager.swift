//
//  OpenCachingApiManager.swift
//  M.O.C
//
//  Created by Tomasz Wojtkowiak on 18/05/2019.
//  Copyright © 2019 Peritum.Net. All rights reserved.
//

import Foundation
import Alamofire

enum OpenCachingApiError: Error {
	case invalidCredentials
}

class OpenCachingApiManager {

	static let shared: OpenCachingApiManager = OpenCachingApiManager()
	
	private let sessionManager: SessionManager
	
	private init() {
		self.sessionManager = SessionManager()
	}
	
	func getGeocache(code: String, completion: @escaping ((_ geocache: Geocache?, _ error: Error?) -> Void)) {
		let params = ["cache_code" : code,
					  "langpref": "pl",
					  "consumer_key": AccessKeys.okapi.rawValue]
		
		sessionManager.request(OpenCachingRouter.getCeocache(params))
			.validate(statusCode: 200..<300)
			.responseData { (response) in
				let decoder = JSONDecoder()
				let cacheResult: Result<Geocache> = decoder.decodeResponse(from: response)
				
				switch cacheResult {
				case .success(let cache):
					completion(cache, nil)
				case .failure(let error):
					if let statusCode = response.response?.statusCode {
						switch statusCode {
						case 401:
							completion(nil, OpenCachingApiError.invalidCredentials)
						default:
							completion(nil, error)
						}
					}
					else {
						completion(nil, error)
					}
				}
			}
				
	}
}
