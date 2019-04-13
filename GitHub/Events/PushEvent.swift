//
//  PushEvent.swift
//  SourceHub
//
//  Created by Will Tyler on 4/10/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import Foundation


extension GitHub {

	struct PushEvent: Codable, GitHubEvent {

		let id: String
		let type: EventType
		let actor: Actor
		let repo: Repo
		let payload: Payload
		let isPublic: Bool
		let createdAt: String

		init(from decoder: Decoder) throws {
			let container = try decoder.container(keyedBy: CodingKeys.self)

			self.type = try container.decode(EventType.self, forKey: .type)

			guard type == .push else {
				let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "")
				throw DecodingError.typeMismatch(PushEvent.self, context)
			}

			// Sometimes id is an Int. Other times it is a String.
			if let id = try? container.decode(Int.self, forKey: .id) {
				self.id = "\(id)"
			}
			else {
				self.id = try container.decode(String.self, forKey: .id)
			}

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


extension GitHub.PushEvent {

	struct Payload: Codable {

		let pushID: Int
		let size: UInt
		let distinctSize: UInt
		let ref: String
		let head: String
		let before: String
		let commits: [Commit]

		private enum CodingKeys: String, CodingKey {
			case pushID = "push_id"
			case size
			case distinctSize = "distinct_size"
			case ref
			case head
			case before
			case commits
		}

	}

	struct Commit: Codable {

		let sha: String
		let author: Author
		let message: String
		let distinct: Bool
		let url: URL

	}

}


extension GitHub.PushEvent.Commit {

	struct Author: Codable {

		let email: String
		let name: String

	}

}
