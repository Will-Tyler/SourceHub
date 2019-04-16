//
//  ForkEvent.swift
//  SourceHub
//
//  Created by Will Tyler on 4/10/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import Foundation


extension GitHub {

	struct ForkEvent: Codable, GitHubEvent {

		public let id: String
		public let type: EventType
		public let actor: Actor
		public let repo: Repo
		public let payload: Payload
		public let isPublic: Bool
		public let createdAt: String

		public init(from decoder: Decoder) throws {
			let container = try decoder.container(keyedBy: CodingKeys.self)

			self.type = try container.decode(EventType.self, forKey: .type)

			guard type == .fork else {
				let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "")
				throw DecodingError.typeMismatch(ForkEvent.self, context)
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


extension GitHub.ForkEvent {

	public struct Payload: Codable {
		public let forkee: Forkee
	}

}


extension GitHub.ForkEvent.Payload {

	public struct Forkee: Codable {

		public let id: UInt
		public let name: String
		public let fullName: String

		private enum CodingKeys: String, CodingKey {
			case id
			case name
			case fullName = "full_name"
		}

	}

}
