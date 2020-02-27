//
//  OpenCachingRouter.swift
//  M.O.C
//
//  Created by Tomasz Wojtkowiak on 18/05/2019.
//  Copyright © 2019 Peritum.Net. All rights reserved.
//

import Foundation
import Alamofire

enum OpenCachingRouter: URLRequestConvertible {
	static let baseURL = "https://opencaching.pl/okapi/"

	case getCeocache([String: Any])
	case getNearestGeochaches([String: Any])
	
	func asURLRequest() throws -> URLRequest {
		var method: HTTPMethod {
			return .get
		}
		
		
		let url: URL = {
			let relativePath: String
			switch self {
			case .getCeocache:
				relativePath = "services/caches/geocaches"
			case .getNearestGeochaches:
				relativePath = "services/caches/shortcuts/search_and_retrieve"
			}
			
			var url = URL(string: OpenCachingRouter.baseURL)!
			url.appendPathComponent(relativePath)
			return url
		}()
		
		let params: ([String: Any]?) = {
			switch self {
			case .getCeocache(let params), .getNearestGeochaches(let params):
				return params
			}
		}()
		
		var needBody: Bool {
			switch self {
			case .getCeocache, .getNearestGeochaches:
				return false
			}
		}
		
		var baseRequest = URLRequest(url: url)
		baseRequest.httpMethod = method.rawValue
		
		if needBody {
			let encoding = JSONEncoding.default
			let encodedRequest = try encoding.encode(baseRequest, with: params)
			return encodedRequest
		}
		else {
			let encoding = URLEncoding.queryString
			let encodedRequest = try encoding.encode(baseRequest, with: params)
			return encodedRequest
		}
	}
}
