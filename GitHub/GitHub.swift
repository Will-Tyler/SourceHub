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
		// Note that loading the client secret on the client is not secure.
		// Were this application to be published, a server would be needed for token swapping.
		let url = Bundle.main.url(forResource: "Client Secret", withExtension: nil)!
		let contents = FileManager.default.contents(atPath: url.path)!

		return String(data: contents, encoding: .utf8)!.trimmingCharacters(in: .whitespacesAndNewlines)
	}()
	private static let accessDataKey = "GitHub.access"
	private static var access: Access? = {
		if let accessData = UserDefaults.standard.data(forKey: accessDataKey), let access = try? JSONDecoder().decode(Access.self, from: accessData) {
			return access
		}
		else {
			return nil
		}
	}() {
		didSet {
			if let access = access, let accessData = try? JSONEncoder().encode(access) {
				UserDefaults.standard.set(accessData, forKey: accessDataKey)
			}
			else {
				UserDefaults.standard.set(nil, forKey: accessDataKey)
			}
		}
	}

	/// A queue of completion handlers that need to be executed with authentication is completed.
	private static var authenticationQueue = [(Error?)->()]()

	/// Return whether a user is authenticated in GitHub.
	static var isAuthenticated: Bool {
		get {
			return access != nil
		}
	}

	/// Opens the GitHub page for authentication.
	///
	/// - Parameters:
	///   - completion: A completion handler that will be passed an Error if an error occured. Guarenteed to execute exactly once.
	static func initiateAuthentication(completion: @escaping (Error?)->()) {
		var loginURL = URL(string: "https://github.com/login/oauth/authorize")!
		let parameters = [
			"client_id": clientID,
			"redirect_uri": "sourcehub://github-callback"
		]

		loginURL.parameters = parameters

		if UIApplication.shared.canOpenURL(loginURL) {
			authenticationQueue.append(completion)
			UIApplication.shared.open(loginURL)
		}
		else {
			completion("SourceHub is unable to open the GitHub authentication url.")
		}
	}

	/// Completes the authentication process once the GitHub authenication page has redirected back to SourceHub.
	/// It is highly unlikely that you need to call this method, unless you are AppDelegate.
	///
	/// - Parameter url: The url that the GitHub authentication page redirected with.
	static func completeAuthentication(with url: URL) {
		guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true), components.scheme == "sourcehub", components.host == "github-callback" else {
			return
		}
		guard let code = url.parameters?["code"] as? String else {
			while !authenticationQueue.isEmpty {
				authenticationQueue.removeFirst()("SourceHub was unable to extract the authentication code from the GitHub callback.")
			}

			return
		}

		let authURL = URL(string: "https://github.com/login/oauth/access_token")!
		let parameters = [
			"client_id": clientID,
			"client_secret": clientSecret,
			"code": code
		]

		HTTP.request(method: .post, authURL, headers: ["Accept": "application/json"], parameters: parameters, with: { (data, response, error) in
			guard let data = data else {
				while !authenticationQueue.isEmpty {
					authenticationQueue.removeFirst()(error)
				}

				return
			}

			do {
				GitHub.access = try JSONDecoder().decode(Access.self, from: data)

				while !authenticationQueue.isEmpty {
					authenticationQueue.removeFirst()(nil)
				}
			}
			catch {
				while !authenticationQueue.isEmpty {
					authenticationQueue.removeFirst()(error)
				}
			}
		})
	}

	/// Signs the user out of GitHub on SourceHub.
	static func deauthenticate() {
		access = nil
	}

	static func handleRepositories(with handler: @escaping ([Repository]?, Error?)->()) {
		guard let access = access else {
			handler(nil, "GitHub user is not authenticated.")
			return
		}

		let parameters = [
			"access_token": access.token,
			"visibility": "all",
			"affiliation": "owner,collaborator",
		]

		HTTP.request(apiURL, endpoint: "user/repos", parameters: parameters, with: { (data, response, error) in
			guard let data = data else {
				handler(nil, error)
				return
			}

			do {
				let repos = try JSONDecoder().decode([Repository].self, from: data)

				handler(repos, nil)
			}
			catch {
				handler(nil, error)
			}
		})
	}

}
