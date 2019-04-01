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
		tabBarItem.image = UIImage(named: "event_note")!.af_imageScaled(to: CGSize(square: 30))
	}
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override func loadView() {
		super.loadView()

		tableView.tableFooterView = UIView(frame: .zero)
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
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

	private func fetchEvents(page: UInt? = nil, completion: (()->())? = nil) {
		GitHub.handleAuthenticatedUser(with: { result in
			switch result {
			case .failure(let error):
				debugPrint(error)

			case .success(let authenticatedUser):
				GitHub.handleReceivedEvents(page: page, login: authenticatedUser.login, with: { result in
					switch result {
					case .failure(let error):
						debugPrint(error)

					case .success(let events):
						if page == nil {
							self.currentPage = 0
							self.events = events
						}
						else {
							self.events.append(contentsOf: events)
						}
					}

					completion?()
				})
			}
		})
	}

	private var currentPage = 1 as UInt
	private var events: [GitHubEvent] = [] {
		didSet {
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return events.count
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let event = events[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)

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
				DispatchQueue.main.async {
					cell.imageView?.image = image?.af_imageScaled(to: CGSize(square: 32)).af_imageRounded(withCornerRadius: 4)
					cell.setNeedsLayout()
				}
			})
		}

		if indexPath.row == events.count-5, currentPage < 10 {
			currentPage += 1
			fetchEvents(page: currentPage)
		}

		return cell
	}
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}

}
