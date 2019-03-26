//
//  GitHub.swift
//  SourceHub
//
//  Created by Will Tyler on 3/18/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit


class GitHub {

	private static let apiURL = URL(string: "https://api.github.com/")!
	private static let clientID = "2d39851172caae950d95"
	private static let clientSecret: String = {
		let url = Bundle.main.url(forResource: "Client Secret", withExtension: nil)!
		let contents = FileManager.default.contents(atPath: url.path)!

		return String(data: contents, encoding: .utf8)!
	}()

	/// Signs in a user to GitHub.
	///
	/// - Parameters:
	///   - username: the username of the user to sign in
	///   - password: the password corresponding to the user
	///   - completion: a completion handler that will be passed an Error if an error occured. Otherwise, it will be passed an AuthenticatedUser.
	static func initiateAuthentication(completion: @escaping (AuthenticatedUser?, Error?)->()) {
		var loginURL = URL(string: "https://github.com/login/oauth/authorize")!
		let parameters = [
			"client_id": clientID,
			"redirect_uri": "sourcehub://github-callback"
		]

		loginURL.parameters = parameters

		if UIApplication.shared.canOpenURL(loginURL) {
			UIApplication.shared.open(loginURL)
		}
	}

}
