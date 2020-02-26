//
//  OpenCachingRequestAdapter.swift
//  M.O.C
//
//  Created by Tomasz Wojtkowiak on 26/02/2020.
//  Copyright © 2020 Peritum.Net. All rights reserved.
//

import Foundation
import Alamofire

class OpenCachingRequestAdapter: RequestAdapter {
    private let accessToken: String
    
    static let nsObjectAppVersion: String = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        urlRequest.addValue(accessToken, forHTTPHeaderField: "Authorization")
		urlRequest.addValue(NSLocale.current.languageCode!, forHTTPHeaderField: "langpref")
        
        return urlRequest
    }
}
