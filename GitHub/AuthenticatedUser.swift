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
		let followersURL: URL
		let followingURL: String
		let starredURL: String
		let reposURL: URL
		let name: String?
		let company: String?
		let location: String?
		let email: String?
		let bio: String?
		let publicReposCount: Int
		let followersCount: Int
		let followingCount: Int
		let totalPrivateReposCount: Int
		let ownedPrivateReposCount: Int

		private enum CodingKeys: String, CodingKey {
			case login
			case id
			case avatarURL = "avatar_url"
			case followersURL = "followers_url"
			case followingURL = "following_url"
			case starredURL = "starred_url"
			case reposURL = "repos_url"
			case name
			case company
			case location
			case email
			case bio
			case publicReposCount = "public_repos"
			case followersCount = "followers"
			case followingCount = "following"
			case totalPrivateReposCount = "total_private_repos"
			case ownedPrivateReposCount = "owned_private_repos"
		}

	}

}
