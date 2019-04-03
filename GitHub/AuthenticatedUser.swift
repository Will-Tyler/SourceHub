//
//  AuthenticatedUser.swift
//  SourceHub
//
//  Created by Will Tyler on 3/18/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import Foundation


extension GitHub {

	struct AuthenticatedUser: Codable {

		let login: String
		let id: Int
		let avatarURL: URL
		let reposURL: URL
		let name: String?
        let email: String?
        let bio: String?

		private enum CodingKeys: String, CodingKey {
			case login
			case id
			case avatarURL = "avatar_url"
			case reposURL = "repos_url"
			case name
			case email
			case bio
		}

	}

}
