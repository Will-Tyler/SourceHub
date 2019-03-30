//
//  FeedViewController.swift
//  SourceHub
//
//  Created by Will Tyler on 3/27/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit


class FeedViewController: UITableViewController {

	convenience init() {
		self.init(nibName: nil, bundle: nil)
	}
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

		title = "Feed"
	}
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override func loadView() {
		super.loadView()

		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
	}
	override func viewDidLoad() {
		super.viewDidLoad()

		refreshControl = UIRefreshControl()
		refreshControl?.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)

		fetchEvents()
	}

	@objc private func refreshControlAction() {
		fetchEvents(completion: { [weak self] in
			DispatchQueue.main.async {
				self?.refreshControl?.endRefreshing()
			}
		})
	}

	private func fetchEvents(completion: (()->())? = nil) {
		GitHub.handleReceivedEvents(with: { (events, error) in
			if let error = error {
				debugPrint(error)
			}
			if let events = events {
				self.events = events
			}

			completion?()
		})
	}

	private var events: [GitHubEvent] = [] {
		didSet {
			DispatchQueue.main.async {
				self.tableView.reloadSections([0], with: .automatic)
			}
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return events.count
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let event = events[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

		if let watchEvent = event as? GitHub.WatchEvent {
			let boldFont = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)
			let attributedMessage = NSMutableAttributedString()
			let boldDisplayLogin = NSMutableAttributedString(string: watchEvent.actor.displayLogin, attributes: [.font: boldFont])
			let boldRepoName = NSAttributedString(string: watchEvent.repo.name, attributes: [.font: boldFont])

			attributedMessage.append(boldDisplayLogin)
			attributedMessage.append(NSAttributedString(string: " starred "))
			attributedMessage.append(boldRepoName)

			cell.textLabel?.numberOfLines = 0
			cell.textLabel?.attributedText = attributedMessage

			watchEvent.actor.handleAvatarImage(with: { image in
				cell.imageView?.image = image?.af_imageScaled(to: CGSize(square: 48)).af_imageRounded(withCornerRadius: 4)
				cell.setNeedsLayout()
			})
		}

		return cell
	}
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}

}
