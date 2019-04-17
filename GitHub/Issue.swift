//
//  Issue.swift
//  SourceHub
//
//  Created by Will Tyler on 4/10/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import Foundation


extension GitHub {

	public struct Issue: Codable {

		public let url: URL
		public let repositoryURL: URL
		public let id: UInt
		public let number: UInt
		public let title: String
		public let state: String
		public let isLocked: Bool

		private enum CodingKeys: String, CodingKey {
			case url
			case repositoryURL = "repository_url"
			case id
			case number
			case title
			case state
			case isLocked = "locked"
		}

	}

}
