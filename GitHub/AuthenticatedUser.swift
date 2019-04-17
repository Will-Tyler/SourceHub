//
//  AuthenticatedUser.swift
//  SourceHub
//
//  Created by Will Tyler on 3/18/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import Foundation


extension GitHub {

	public struct AuthenticatedUser: Codable {

		public let login: String
		public let id: Int
		public let avatarURL: URL
		public let followersURL: URL
		public let followingURL: String
		public let starredURL: String
		public let reposURL: URL
		public let name: String?
		public let company: String?
		public let location: String?
		public let email: String?
		public let bio: String?
		public let publicReposCount: Int
		public let followersCount: Int
		public let followingCount: Int
		public let totalPrivateReposCount: Int
		public let ownedPrivateReposCount: Int

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
