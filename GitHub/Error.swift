//
//  GitHubError.swift
//  SourceHub
//
//  Created by Will Tyler on 4/1/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import Foundation


enum GitHubError: String, Error {

	case notAuthenticated = "A GitHub user has not been authenticated."
	case apiError = "There was an error communicating with the GitHub API."
	case cannotOpenAuthenticationURL = "SourceHub is unable to open the authentication URL for GitHub."
	case couldNotExtractCode = "SourceHub was unable to extract the authentication code from the GitHub callback."

}
