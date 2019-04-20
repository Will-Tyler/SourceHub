//
//  GitHub.swift
//  SourceHub
//
//  Created by Will Tyler on 3/18/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit
import SafariServices


public class GitHub {

	private static let apiURL = URL(string: "https://api.github.com/")!
	static let clientID = "2d39851172caae950d95"
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
	private static var authenticationQueue = [(Swift.Error?)->()]()
	/// A SFSafariViewController might be used to present the GitHub login page.
	private static var safariViewController: SFSafariViewController?

	/// Return whether a user is authenticated in GitHub.
	public static var isAuthenticated: Bool {
		get {
			return access != nil
		}
	}

	/// Opens the GitHub page for authentication.
	///
	/// - Parameters:
	///   - completion: A completion handler that will be passed an Error if an error occured. Guarenteed to execute exactly once.
	public static func initiateAuthentication(completion: @escaping (Swift.Error?)->()) {
		var loginURL = URL(string: "https://github.com/login/oauth/authorize")!
		let parameters = [
			"client_id": clientID,
			"redirect_uri": "sourcehub://github-callback",
			"scope": "user repo"
		]

		loginURL.parameters = parameters

		if var viewController = UIApplication.shared.keyWindow?.rootViewController {
			while let presented = viewController.presentedViewController {
				viewController = presented
			}

			let safariViewController = SFSafariViewController(url: loginURL)

			GitHub.safariViewController = safariViewController
			viewController.present(safariViewController, animated: true)
			authenticationQueue.append(completion)
		}
		else if UIApplication.shared.canOpenURL(loginURL) {
			authenticationQueue.append(completion)
			UIApplication.shared.open(loginURL)
		}
		else {
			completion(Error.cannotOpenAuthenticationURL)
		}
	}

	/// Completes the authentication process once the GitHub authenication page has redirected back to SourceHub.
	/// It is highly unlikely that you need to call this method, unless you are the AppDelegate.
	///
	/// - Parameter url: The url that the GitHub authentication page redirected with.
	public static func completeAuthentication(with url: URL) {
		guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true), components.scheme == "sourcehub", components.host == "github-callback" else {
			return
		}

		safariViewController?.dismiss(animated: true)
		safariViewController = nil

		guard let code = url.parameters?["code"] as? String else {
			while !authenticationQueue.isEmpty {
				authenticationQueue.removeFirst()(Error.couldNotExtractCode)
			}

			return
		}

		let authURL = URL(string: "https://sourcehub-server.herokuapp.com/token")!
		let accessRequest = AccessRequest(code: code)

		do {
			let requestData = try JSONEncoder().encode(accessRequest)

			HTTP.request(method: .post, authURL, headers: ["Content-Type": "application/json"], body: requestData, with: { (data, response, error) in
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
		catch {
			while !authenticationQueue.isEmpty {
				authenticationQueue.removeFirst()(error)
			}
		}
	}

	/// Signs the user out of GitHub on SourceHub.
	public static func deauthenticate() {
		access = nil
	}

	/// Fetches the repositories belonging to the currently signed in user.
	///
	/// - Parameter handler: a Handler that will be passed the user's repositories or an error if one occurs.
	public static func handleRepositories(with handler: Handler<[Repository], Swift.Error>) {
		guard let access = access else {
			handler(.failure(Error.notAuthenticated))
			return
		}

		let parameters = [
			"access_token": access.token,
			"visibility": "all",
			"affiliation": "owner,collaborator",
		]

		HTTP.request(apiURL, endpoint: "user/repos", parameters: parameters, with: { (data, response, error) in
			guard let data = data else {
				handler(.failure(error ?? Error.apiError))
				return
			}

			do {
				let repos = try JSONDecoder().decode([Repository].self, from: data)

				handler(.success(repos))
			}
			catch {
				handler(.failure(error))
			}
		})
	}

	/// Fetches the currently authenticated user from GitHub.
	///
	/// - Parameter handler: a Handler that will be passed the authenticated user or an error if one occurs.
	public static func handleAuthenticatedUser(with handler: Handler<AuthenticatedUser, Swift.Error>) {
		guard let access = access else {
			handler(.failure(Error.notAuthenticated))
			return
		}

		HTTP.request(apiURL, endpoint: "user", headers: ["Authorization": "token \(access.token)"], with: { (data, response, error) in
			guard let data = data else {
				handler(.failure(error ?? Error.apiError))
				return
			}

			do {
				let user = try JSONDecoder().decode(AuthenticatedUser.self, from: data)

				handler(.success(user))
			}
			catch {
				handler(.failure(error))
			}
		})
	}

	/// Fetches the user's received events from GitHub.
	/// Each page returns 30 events, and there are at most 10 pages.
	/// The pages are indexed starting at 1.
	///
	/// - Parameters:
	///   - page: the page of events to fetch
	///   - login: the username of the GitHub user to fetch events for
	///   - handler: a Handler that is passed an array of GitHubEvents or an error if one occurs
	public static func handleReceivedEvents(page: UInt? = nil, login: String, with handler: Handler<[GitHubEvent], Swift.Error>) {
		guard let access = access else {
			handler(.failure(Error.notAuthenticated))
			return
		}

		let parameters: URL.Parameters?

		if var page = page {
			page = max(1, min(page, 10))
			parameters = ["page": String(page)]
		}
		else {
			parameters = nil
		}

		HTTP.request(apiURL, endpoint: "users/\(login)/received_events", headers: ["Authorization": "token \(access.token)"], parameters: parameters, with: { (data, response, error) in
			guard let data = data else {
				handler(.failure(error ?? Error.apiError))
				return
			}

			do {
				let events = try JSONDecoder().decode([EventDecoder].self, from: data).compactMap({ $0.event })

				handler(.success(events))
			}
			catch {
				handler(.failure(error))
			}
		})
	}

	/// Fetches the commits from a repo.
    /// Path component used to go into dir or file
	///
	/// - Parameter handler: a Handler that will be passed the commits or an error if one occurs.
    public static func handleCommits(owner: String, repo: String, with handler: Handler<[Commit], Swift.Error>) {
		guard let access = access else {
			handler(.failure(Error.notAuthenticated))
			return
		}

		let parameters = [
			"access_token": access.token,
			"sha": "master"
		]

		HTTP.request(apiURL, endpoint: "repos/\(owner)/\(repo)/commits", parameters: parameters, with: { (data, response, error) in
			guard let data = data else {
				handler(.failure(error ?? Error.apiError))
				return
			}

			do {
				let commits = try JSONDecoder().decode([Commit].self, from: data)

				handler(.success(commits))
			}
			catch {
				handler(.failure(error))
			}
		})
	}
    
    /// Fetches the contents of a repo.
    ///
    /// - Parameter handler: a Handler that will be passed the contents or an error if one occurs.
    public static func handleContents(owner: String, repo: String, path: String? = "", with handler: Handler<[Content], Swift.Error>) {
        guard let access = access else {
            handler(.failure(Error.notAuthenticated))
            return
        }
        
        let parameters = [
            "access_token": access.token,
        ]
        
        var url = "repos/\(owner)/\(repo)/contents"
        if let path = path {
            url += path
        }
        
        HTTP.request(apiURL, endpoint: url, parameters: parameters, with: { (data, response, error) in
            guard let data = data else {
                handler(.failure(error ?? Error.apiError))
                return
            }
            
            do {
                let result: [Content]
                
                if let contents = try? JSONDecoder().decode([Content].self, from: data) {
                    result = contents
                }
                else {
                    result = [try JSONDecoder().decode(Content.self, from: data)]
                }

                handler(.success(result))
            }
            catch {
                handler(.failure(error))
            }
        })
    }

}
