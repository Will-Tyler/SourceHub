//
//  GitHubEvent.swift
//  SourceHub
//
//  Created by Will Tyler on 4/10/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit
import GitHub


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

			case .pullRequestReviewComment:
				guard let pullRequestReviewCommentEvent = self as? GitHub.PullRequestReviewCommentEvent else {
					assertionFailure()
					receiver = repo.name
					break
				}

				let pullRequest = pullRequestReviewCommentEvent.payload.pullRequest

				receiver = "[\(pullRequestReviewCommentEvent.repo.name) \(pullRequest.title) (#\(pullRequest.number))]"

			default:
				assertionFailure()
				receiver = repo.name
			}

			let url = URL(string: "sourcehub://repo/\(repo.id)")!
			let attributes: [NSAttributedString.Key: Any] = [.font: boldFont, .link: url]
			let boldRepoName = NSAttributedString(string: receiver, attributes: attributes)
			let actions: [GitHub.EventType: String] = [
				.create: "created a repository",
				.delete: "deleted",
				.fork: "forked",
				.issueComment: "commented on",
				.issues: "opened an issue",
				.pullRequest: "opened a pull request",
				.pullRequestReviewComment: "commented on",
				.push: "pushed to",
				.watch: "starred"
			]
			let action = actions[type]

			assert(action != nil)

			attributedMessage.append(boldDisplayLogin)
			attributedMessage.append(NSAttributedString(string: " \(action ?? "") "))
			attributedMessage.append(boldRepoName)

			return attributedMessage
		}
	}

}
