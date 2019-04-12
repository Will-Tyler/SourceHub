//
//  GitHubEvent.swift
//  SourceHub
//
//  Created by Will Tyler on 4/10/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit


extension GitHubEvent {

	var description: NSAttributedString {
		get {
			let boldFont = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
			let attributedMessage = NSMutableAttributedString()
			let boldDisplayLogin = NSAttributedString(string: actor.displayLogin, attributes: [.font: boldFont])
			let receiver: String

			switch type {
			case .create, .fork, .pullRequest, .push, .watch:
				receiver = repo.name

			case .delete:
				let deleteEvent = self as! GitHub.DeleteEvent

				receiver = deleteEvent.payload.ref

			case .issues:
				if let issuesEvent = self as? GitHub.IssuesEvent {
					let issue = issuesEvent.payload.issue

					receiver = "[\(repo.name)] \(issue.title) (#\(issue.number))"
				}
				else {
					assertionFailure()
					receiver = "[\(repo.name)]"
				}

			case .issueComment:
				guard let issueCommentEvent = self as? GitHub.IssueCommentEvent else {
					assertionFailure()
					receiver = repo.name
					break
				}

				let issue = issueCommentEvent.payload.issue

				receiver = "[\(repo.name)] \(issue.title) (#\(issue.number))"

			default:
				assertionFailure()
				receiver = repo.name
			}

			let boldRepoName = NSAttributedString(string: receiver, attributes: [.font: boldFont])

			attributedMessage.append(boldDisplayLogin)

			let actions: [GitHub.EventType: String] = [
				.create: "created a repository",
				.delete: "deleted",
				.fork: "forked",
				.issueComment: "commented on",
				.issues: "opened",
				.pullRequest: "opened",
				.push: "pushed to",
				.watch: "starred"
			]
			let action = actions[type]

			assert(action != nil)

			attributedMessage.append(NSAttributedString(string: " \(action ?? "") "))
			attributedMessage.append(boldRepoName)

			return attributedMessage
		}
	}

}
