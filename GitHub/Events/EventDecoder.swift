//
//  EventDecoder.swift
//  SourceHub
//
//  Created by Will Tyler on 3/29/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import Foundation


extension GitHub {

	struct EventDecoder: Decodable {

		private var _event: GitHubEvent?
		var event: GitHubEvent? {
			get {
				return _event
			}
			set {
				// Only set _event if it hasn't been set yet.
				if _event == nil {
					_event = newValue
				}
			}
		}

		init(from decoder: Decoder) throws {
			let container = try decoder.singleValueContainer()

			event = try? container.decode(CreateEvent.self)
			event = try? container.decode(DeleteEvent.self)
			event = try? container.decode(ForkEvent.self)
			event = try? container.decode(IssueCommentEvent.self)
			event = try? container.decode(IssuesEvent.self)
			event = try? container.decode(MemberEvent.self)
			event = try? container.decode(PullRequestEvent.self)
			event = try? container.decode(PushEvent.self)
			event = try? container.decode(WatchEvent.self)

			// For use when all known event types are handled.
			if event == nil {
				let simpleEvent = try container.decode(SimpleEvent.self)
				let context = DecodingError.Context(codingPath: container.codingPath, debugDescription: "Unable to decode event with type \"\(simpleEvent.type)\"")

				throw DecodingError.typeMismatch(GitHubEvent.self, context)
			}
		}

	}

	private struct SimpleEvent: Codable {
		let type: String
	}

}
