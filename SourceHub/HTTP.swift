//
//  HTTP.swift
//  SourceHub
//
//  Created by Will Tyler on 3/25/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import Foundation


class HTTP {

	typealias Request = URLSessionDataTask

	@discardableResult
	static func request(method: HTTP.Request.Method = .get, _ baseURL: URL, endpoint: String? = "", headers: [String: String]? = nil, parameters: URL.Parameters? = nil, body: Any? = nil, with handler: @escaping (Data?, URLResponse?, Error?)->()) -> HTTP.Request {
		var url = baseURL

		if let endpoint = endpoint {
			url.appendPathComponent(endpoint)
		}
		if let parameters = parameters {
			url.parameters = parameters
		}

		print(method.rawValue, url)

		var request = URLRequest(url: url)

		request.httpMethod = method.rawValue

		if let headers = headers {
			for (key, value) in headers {
				request.setValue(value, forHTTPHeaderField: key)
			}
		}
		if let body = body {
			request.httpBody = try? JSONSerialization.data(withJSONObject: body)
		}

		let task = URLSession.shared.dataTask(with: request, completionHandler: handler)

		task.resume()

		return task
	}

}


extension HTTP.Request {

	enum Method: String {

		case get = "GET"
		case post = "POST"

	}

}
