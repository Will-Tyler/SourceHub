//
//  Contents.swift
//  SourceHub
//
//  Created by APPLE on 4/15/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit


public extension GitHub {

	struct Content: Codable {

		public let type: ContentType
		public let size: Int
		public let name: String
		public let path: String
		public let url: URL
		public let downloadURL: URL?


		private enum CodingKeys: String, CodingKey {

			case type, size, name, path, url
			case downloadURL = "download_url"

		}

	}

}


public extension GitHub.Content {

	enum ContentType: String, Codable {

		case file = "file"
		case directory = "dir"

	}

}
