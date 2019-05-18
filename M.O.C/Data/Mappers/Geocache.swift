//
//  Geocache.swift
//  M.O.C
//
//  Created by Tomasz Wojtkowiak on 18/05/2019.
//  Copyright © 2019 Peritum.Net. All rights reserved.
//

import Foundation

struct Geocache: Codable {
	
	var code: String
	var name: String
	
	enum CodingKeys: String, CodingKey {
		case code
		case name
	}
}
