//
//  OpenCachingApiManager.swift
//  M.O.C
//
//  Created by Tomasz Wojtkowiak on 18/05/2019.
//  Copyright © 2019 Peritum.Net. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

enum OpenCachingApiError: Error {
	case invalidCredentials
}

typealias ApiFailureHandler = ((_ error: Error) -> Void)

class OpenCachingApiManager {

	static let shared: OpenCachingApiManager = OpenCachingApiManager()
	
	private let sessionManager: SessionManager
	
	private init() {
		self.sessionManager = SessionManager()
		self.sessionManager.adapter = OpenCachingRequestAdapter(accessToken: AccessKeys.okapi.rawValue)
	}
	
	func getGeocache(code: String, success: @escaping ((_ geocache: Geocache) -> Void), failure: @escaping ApiFailureHandler) {
		let params = ["cache_code" : code,
					  "langpref": "pl"]
		
		sessionManager.request(OpenCachingRouter.getCeocache(params))
			.validate(statusCode: 200..<300)
			.responseData { (response) in
				let decoder = JSONDecoder()
				let cacheResult: Result<Geocache> = decoder.decodeResponse(from: response)
				
				switch cacheResult {
				case .success(let cache):
					success(cache)
				case .failure(let error):
					self.handle(error: error, response: response, handler: failure)
				}
			}
	}
	
//	func getNearestGeocaches(toPoint coordinates: CLLocationCoordinate2D, radius: Float, success: @escaping ((_ geocaches: [Geocache]) -> Void), failure: @escaping ApiFailureHandler) {
//		let params: [String: Any] = ["center": "\(coordinates.latitude)|\(coordinates.longitude)",
//									"radius": radius]
//		
//		let decoder = JSONDecoder()
//
//		sessionManager.request(OpenCachingRouter.getNearestGeochaches(params))
//			.validate(statusCode: 200..<300)
//			.responseDecodable (decoder: jsonDecoder){ (response: DataResponse<[Article]>) in
//				
//				let cacheResult: Result<[Geocache]> = decoder.decodeResponse(from: response)
//				
//				switch cacheResult {
//				case .success(let cache):
//					success(cache)
//				case .failure(let error):
//					self.handle(error: error, response: response, handler: failure)
//				}
//			}
//	}
	
	
	//MARK: - Private
	private func handle(error: Error, response: DataResponse<Any>, handler: @escaping ApiFailureHandler) {
		if let resp = response.response, resp.statusCode == 401 {
			self.handleAuthError()
		}
		handler(error)
	}
	
	private func handle<T: Decodable>(error: Error, response: DataResponse<T>, handler: @escaping ApiFailureHandler) {
		self.handle(fromLogin: false, error: error, response: response, handler: handler)
	}
	
	private func handle<T: Decodable>(fromLogin: Bool, error: Error, response: DataResponse<T>, handler: @escaping ApiFailureHandler) {
		if let resp = response.response, resp.statusCode == 401 {
			if !fromLogin {
				self.handleAuthError()
			}
		}
		handler(error)
	}
	
	private func handleAuthError() {
		//handle auth error
	}
}
