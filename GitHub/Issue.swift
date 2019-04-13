//
//  Issue.swift
//  SourceHub
//
//  Created by Will Tyler on 4/10/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import Foundation


extension GitHub {

	struct Issue: Codable {

		let url: URL
		let repositoryURL: URL
		let id: UInt
		let number: UInt
		let title: String
		let state: String
		let isLocked: Bool

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
