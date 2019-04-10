//
//  GitHubEvent.swift
//  SourceHub
//
//  Created by Will Tyler on 4/10/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit


extension GitHubEvent {

	var attributedMessage: NSAttributedString {
		get {
			let boldFont = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
			let attributedMessage = NSMutableAttributedString()
			let boldDisplayLogin = NSAttributedString(string: actor.displayLogin, attributes: [.font: boldFont])
			let boldRepoName = NSAttributedString(string: repo.name, attributes: [.font: boldFont])

			attributedMessage.append(boldDisplayLogin)

			let action: String

			switch type {
			case .create:
				action = "created a repository"

			case .push:
				action = "pushed to"

			case .watch:
				action = "starred"

			default:
				assertionFailure()
				action = ""
			}

			attributedMessage.append(NSAttributedString(string: " \(action) "))
			attributedMessage.append(boldRepoName)

			return attributedMessage
		}
	}

}
