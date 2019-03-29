//
//  Event.swift
//  SourceHub
//
//  Created by Will Tyler on 3/29/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import Foundation


extension GitHub {

	enum EventType: String, Codable {

		case checkRun = "CheckRunEvent"
		case checkSuite = "CheckSuiteEvent"
		case commitComment = "CommitCommentEvent"
		case contentReference = "ContentReferenceEvent"
		case create = "CreateEvent"
		case delete = "DeleteEvent"
		case deployment = "DeploymentEvent"
		case deploymentStatus = "DeploymentStatusEvent"
		case download = "DownloadEvent"
		case follow = "FollowEvent"
		case fork = "ForkEvent"
		case forkApply = "ForkApplyEvent"
		case gitHubAppAuthorization = "GitHubAppAuthorizationEvent"
		case gist = "GistEvent"
		case gollum = "GollumEvent"
		case installation = "InstallationEvent"
		case installationRepositories = "InstallationRepositoriesEvent"
		case issueComment = "IssueCommentEvent"
		case issues = "IssuesEvent"
		case label = "LabelEvent"
		case marketplacePurchase = "MarketplacePurchaseEvent"
		case member = "MemberEvent"
		case membership = "MembershipEvent"
		case milestone = "MilestoneEvent"
		case organization = "OrganizationEvent"
		case orgBlock = "OrgBlockEvent"
		case pageBuild = "PageBuildEvent"
		case projectCard = "ProjectCardEvent"
		case projectColumn = "ProjectColumnEvent"
		case project = "ProjectEvent"
		case `public` = "PublicEvent"
		case pullRequest = "PullRequestEvent"
		case pullRequestReview = "PullRequestReviewEvent"
		case pullRequestReviewComment = "PullRequestReviewCommentEvent"
		case push = "PushEvent"
		case release = "ReleaseEvent"
		case repository = "RepositoryEvent"
		case repositoryImport = "RepositoryImportEvent"
		case repositoryVulnerabilityAlert = "RepositoryVulnerabilityAlertEvent"
		case securityAdvisory = "SecurityAdvisoryEvent"
		case status = "StatusEvent"
		case team = "TeamEvent"
		case teamAdd = "TeamAddEvent"
		case watch = "WatchEvent"

	}

}

protocol GitHubEvent: Codable {

	var id: String { get }
	var type: GitHub.EventType { get }
	var isPublic: Bool { get }
	var createdAt: String { get }

}
