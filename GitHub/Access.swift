//
//  AccessToken.swift
//  SourceHub
//
//  Created by Will Tyler on 3/26/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import Foundation


extension GitHub {

	struct Access: Codable {

		let token: String
		let type: String
		let scope: String

		private enum CodingKeys: String, CodingKey {

			case token = "access_token"
			case type = "token_type"
			case scope

		}

	}

}
