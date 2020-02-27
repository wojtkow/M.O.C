//
//  OpenCachingRequestInterceptor.swift
//  M.O.C
//
//  Created by Tomasz Wojtkowiak on 27/02/2020.
//  Copyright © 2020 Peritum.Net. All rights reserved.
//

import Foundation
import Alamofire

final class OpenCachingRequestInterceptor: RequestInterceptor {
	
	func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
//		guard urlRequest.url?.absoluteString.hasPrefix("https://opencaching.pl/okapi/services/oauth") == true else {
//			return completion(.success(urlRequest))
//		}
		var urlRequest = urlRequest

		let accessToken = "OAuth oauth_consumer_key=\"\(AccessKeys.okapiKey.rawValue)\", oauth_nonce=\"\", oauth_signature=\"\(AccessKeys.okapiSecret.rawValue)%26\", oauth_signature_method=\"PLAINTEXT\", oauth_timestamp=\"\(Int(Date().timeIntervalSince1970))\", oauth_version=\"1.0\""
        urlRequest.addValue(accessToken, forHTTPHeaderField: "Authorization")
		urlRequest.addValue(NSLocale.current.languageCode!, forHTTPHeaderField: "langpref")
        
        completion(.success(urlRequest))
    }
}
