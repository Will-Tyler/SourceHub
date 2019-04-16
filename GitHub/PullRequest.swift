//
//  PullRequest.swift
//  SourceHub
//
//  Created by Will Tyler on 4/12/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import Foundation


extension GitHub {

	public struct PullRequest: Codable {

		public let url: URL
		public let id: UInt
		public let number: UInt
		public let state: String
		public let title: String
		public let body: String

	}

}
