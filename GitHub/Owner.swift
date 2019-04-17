//
//  Owner.swift
//  SourceHub
//
//  Created by Will Tyler on 3/18/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import Foundation


public extension GitHub {

	struct Owner: Codable {

		public let login: String
		let id: Int
		let url: String
		let reposURL: URL

		// TODO CodingKeys
		private enum CodingKeys: String, CodingKey {
			case login
			case id
			case url
			case reposURL = "repos_url"
		}

	}

}
