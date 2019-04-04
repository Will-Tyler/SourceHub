//
//  WatchEvent.swift
//  SourceHub
//
//  Created by Will Tyler on 3/29/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit


extension GitHub {

	struct WatchEvent: Codable, GitHubEvent {

		let id: String
		let type: EventType
		let actor: Actor
		let repo: Repo
		let payload: Payload
		let isPublic: Bool
		let createdAt: String

		init(from decoder: Decoder) throws {
			let container = try decoder.container(keyedBy: CodingKeys.self)

			// Sometimes id is an Int. Other times it is a String.
			if let id = try? container.decode(Int.self, forKey: .id) {
				self.id = "\(id)"
			}
			else {
				self.id = try container.decode(String.self, forKey: .id)
			}

			self.type = try container.decode(EventType.self, forKey: .type)
			self.actor = try container.decode(Actor.self, forKey: .actor)
			self.repo = try container.decode(Repo.self, forKey: .repo)
			self.payload = try container.decode(Payload.self, forKey: .payload)
			self.isPublic = try container.decode(Bool.self, forKey: .isPublic)
			self.createdAt = try container.decode(String.self, forKey: .createdAt)
		}

		private enum CodingKeys: String, CodingKey {
			case id
			case type
			case actor
			case repo
			case payload
			case isPublic = "public"
			case createdAt = "created_at"
		}

	}

}


extension GitHub.WatchEvent {

	struct Actor: Codable {

		let id: Int
		let login: String
		let displayLogin: String
		let gravatarID: String
		let url: URL
		let avatarURL: URL

		func handleAvatarImage(with handler: Handler<UIImage, Swift.Error>) {
			let request = URLRequest(url: avatarURL)

			imageDownloader.download(request, completion: { (dataResponse) in
				if let image = dataResponse.value {
					handler(.success(image))
				}
				else {
					handler(.failure(dataResponse.error ?? GitHub.Error.apiError))
				}
			})
		}

		private enum CodingKeys: String, CodingKey {
			case id
			case login
			case displayLogin = "display_login"
			case gravatarID = "gravatar_id"
			case url
			case avatarURL = "avatar_url"
		}

	}

	struct Repo: Codable {

		let id: Int
		let name: String
		let url: URL

	}

	struct Payload: Codable {

		let action: String

	}

}
