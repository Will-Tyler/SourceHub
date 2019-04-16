//
//  AccessRequest.swift
//  GitHub
//
//  Created by Will Tyler on 4/16/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import Foundation


extension GitHub {

	struct AccessRequest: Codable {

		private let teamID: String
		private let clientID: String
		private let code: String

		init(code: String) {
			self.teamID = "TEAM"
			self.clientID = GitHub.clientID
			self.code = code
		}

		private enum CodingKeys: String, CodingKey {
			case teamID = "team_id"
			case clientID = "client_id"
			case code
		}

	}

}
