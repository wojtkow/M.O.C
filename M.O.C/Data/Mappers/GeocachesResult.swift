//
//  GeocachesResult.swift
//  M.O.C
//
//  Created by Tomasz Wojtkowiak on 27/02/2020.
//  Copyright © 2020 Peritum.Net. All rights reserved.
//

import Foundation

struct GeocachesResult: Codable {
	let results: [Geocache]
	let more: Bool
	
	enum CodingKeys: String, CodingKey {
		case results
		case more
	}
}
