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

		let event: GitHubEvent?

		init(from decoder: Decoder) throws {
			let container = try decoder.singleValueContainer()

			event = try? container.decode(WatchEvent.self)
		}

	}

}
