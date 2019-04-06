//
//  String.swift
//  SourceHub
//
//  Created by Will Tyler on 3/25/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import Foundation


extension String: Error {}

extension String {

	func base64Encoded() -> String? {
		return data(using: .utf8)?.base64EncodedString()
	}

}
