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

			event = try? container.decode(PushEvent.self)
			event = try? container.decode(WatchEvent.self)
		}

	}

}
