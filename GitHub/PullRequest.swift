//
//  PullRequest.swift
//  SourceHub
//
//  Created by Will Tyler on 4/12/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import Foundation


extension GitHub {

	struct PullRequest: Codable {

		let url: URL
		let id: UInt
		let number: UInt
		let state: String
		let title: String
		let body: String

	}

}
