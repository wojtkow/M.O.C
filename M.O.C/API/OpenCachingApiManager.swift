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
	
	private let sessionManager: Session
	
	private init() {
		self.sessionManager = Session(interceptor: OpenCachingRequestInterceptor())
	}
	
	func getGeocache(code: String, success: @escaping ((_ geocache: Geocache) -> Void), failure: @escaping ApiFailureHandler) {
		let params = ["cache_code" : code,
					  "langpref": "pl"]
		
		sessionManager.request(OpenCachingRouter.getCeocache(params))
			.validate(statusCode: 200..<300)
			.responseDecodable(of: Geocache.self){ (response) in
				switch response.result {
				case .success(let cache):
					success(cache)
				case .failure(let error):
					self.handle(error: error, response: response, handler: failure)
				}
			}
	}
	
	func getNearestGeocaches(toPoint coordinates: CLLocationCoordinate2D, radius: Float, success: @escaping ((_ geocaches: GeocachesResult) -> Void), failure: @escaping ApiFailureHandler) {
		let params: [String: Any] = ["search_params": "{\"center\": \"\(coordinates.latitude)|\(coordinates.longitude)\", \"radius\": \(radius)}",
			"search_method": "services/caches/search/nearest",
			"retr_method": "services/caches/geocaches",
			"retr_params": "{\"fields\": \"name|location|type}\"",
			"wrap": true]
		
		
		sessionManager.request(OpenCachingRouter.getNearestGeochaches(params))
			.validate(statusCode: 200..<300)
			.responseDecodable(of: GeocachesResult.self){ (response) in
				switch response.result {
				case .success(let caches):
					success(caches)
				case .failure(let error):
					self.handle(error: error, response: response, handler: failure)
				}
			}
	}
	
	
	//MARK: - Private
	private func handle(error: Error, response: DataResponse<Any, AFError>, handler: @escaping ApiFailureHandler) {
		if let resp = response.response, resp.statusCode == 401 {
			self.handleAuthError()
		}
		handler(error)
	}
	
	private func handle<T: Decodable>(error: Error, response: DataResponse<T, AFError>, handler: @escaping ApiFailureHandler) {
		self.handle(fromLogin: false, error: error, response: response, handler: handler)
	}
	
	private func handle<T: Decodable>(fromLogin: Bool, error: Error, response: DataResponse<T, AFError>, handler: @escaping ApiFailureHandler) {
		if let resp = response.response, resp.statusCode == 401 {
			if !fromLogin {
				self.handleAuthError()
			}
		}
		if let data = response.data {
			if let str = String(data: data, encoding: .utf8) {
				print("\(str)")
			}
		}
		handler(error)
	}
	
	private func handleAuthError() {
		//handle auth error
	}
}
