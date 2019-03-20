//
//  Repository.swift
//  SourceHub
//
//  Created by Will Tyler on 3/18/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import Foundation


extension GitHub {

	struct Repository: Codable {

		let id: Int
		let nodeID: String
		let name: String
		let fullName: String
		let owner: Owner
		let isPrivate: Bool
		let description: String
		let isFork: Bool
		let url: URL
		let defaultBranch: String

		private enum CodingKeys: String, CodingKey {
			case id
			case nodeID = "node_id"
			case name
			case fullName = "full_name"
			case owner
			case isPrivate = "private"
			case description
			case isFork = "fork"
			case url
			case defaultBranch = "default_branch"
		}

	}

}
