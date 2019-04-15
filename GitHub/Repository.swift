//
//  Repository.swift
//  SourceHub
//
//  Created by Will Tyler on 3/18/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import Foundation


public extension GitHub {

	struct Repository: Codable {

		public let id: Int
		public let nodeID: String
		public let name: String
		public let fullName: String
		public let owner: Owner
		public let isPrivate: Bool
		public let description: String?
		public let isFork: Bool
		public let url: URL
		public let defaultBranch: String

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
