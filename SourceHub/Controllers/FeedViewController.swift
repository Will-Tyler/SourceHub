//
//  FeedViewController.swift
//  SourceHub
//
//  Created by Will Tyler on 3/27/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit
import GitHub


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

	private lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(navigationBarAction))

	override func loadView() {
		super.loadView()

		tableView.tableFooterView = UIView(frame: .zero)
		tableView.register(EventTableViewCell.self)
	}
	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = Colors.background

		refreshControl = UIRefreshControl()
		refreshControl?.addTarget(self, action: #selector(refreshControlAction), for: .valueChanged)

		fetchEvents(page: currentPage)
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		navigationController?.navigationBar.addGestureRecognizer(tapGesture)
	}
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)

		navigationController?.navigationBar.removeGestureRecognizer(tapGesture)
	}

	@objc private func navigationBarAction() {
		tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
	}

	@objc private func refreshControlAction() {
		fetchEvents(completion: { [weak self] in
			DispatchQueue.main.async {
				self?.refreshControl?.endRefreshing()
			}
		})
	}

	private func fetchEvents(page: UInt? = nil, completion: (()->())? = nil) {
		GitHub.handleAuthenticatedUser(with: Handler { [weak self] result in
			switch result {
			case .failure(let error):
				debugPrint(error)

				DispatchQueue.main.async {
					self?.alertUser(title: "Error Fetching Events", message: error.localizedDescription)
				}

			case .success(let authenticatedUser):
				GitHub.handleReceivedEvents(page: page, login: authenticatedUser.login, with: Handler { result in
					switch result {
					case .failure(let error):
						debugPrint(error)

					case .success(var events):
						events.removeAll(where: { $0 is GitHub.MemberEvent })

						if page == nil {
							self?.currentPage = 0
							self?.events = events

							DispatchQueue.main.async {
								self?.tableView.reloadSections([0], with: .automatic)
							}
						}
						else {
							self?.events.append(contentsOf: events)

							DispatchQueue.main.async {
								self?.tableView.reloadData()
							}
						}
					}

					completion?()
				})
			}
		})
	}

	private var currentPage = 1 as UInt
	private var events = [GitHubEvent]()

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return events.count
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let event = events[indexPath.row]
		let cell = tableView.dequeueReusableCell(ofType: EventTableViewCell.self, for: indexPath) as! EventTableViewCell

		cell.event = event

		if indexPath.row == max(0, events.count-5), currentPage < 10 {
			currentPage += 1
			fetchEvents(page: currentPage)
		}

		return cell
	}
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}

}
