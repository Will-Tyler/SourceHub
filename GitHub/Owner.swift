//
//  Owner.swift
//  SourceHub
//
//  Created by Will Tyler on 3/18/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import Foundation


extension GitHub {

	struct Owner: Codable {

		let login: String
		let id: Int
		let url: String
		let reposURL: URL

		// TODO CodingKeys
	}

}
