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

	private var events: [GitHubEvent] = [] {
		didSet {
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}

	override func loadView() {
		super.loadView()

		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
	}
	override func viewDidLoad() {
		super.viewDidLoad()

		GitHub.handleReceivedEvents(with: { (events, error) in
			if let error = error {
				debugPrint(error)
			}
			if let events = events {
				self.events.append(contentsOf: events)
			}
		})
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return events.count
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let event = events[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

		if let watchEvent = event as? GitHub.WatchEvent {
			cell.textLabel?.numberOfLines = 0
			cell.textLabel?.text = "\(watchEvent.actor.displayLogin) starred \(watchEvent.repo.name)"
		}

		return cell
	}
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}

}
