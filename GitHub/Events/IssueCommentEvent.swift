//
//  IssueCommentEvent.swift
//  SourceHub
//
//  Created by Will Tyler on 4/10/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import Foundation


extension GitHub {

	public struct IssueCommentEvent: Codable, GitHubEvent {

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

			guard type == .issueComment else {
				let context = DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "")
				throw DecodingError.typeMismatch(IssueCommentEvent.self, context)
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


extension GitHub.IssueCommentEvent {

	public struct Payload: Codable {

		public let action: String
		public let issue: GitHub.Issue
		public let comment: Comment

	}

}


extension GitHub.IssueCommentEvent.Payload {

	public struct Comment: Codable {

		let url: URL
		let id: UInt
		let body: String

	}

}
