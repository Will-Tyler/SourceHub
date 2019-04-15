//
//  ReposViewController.swift
//  SourceHub
//
//  Created by Will Tyler on 4/5/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit
import GitHub


class ReposViewController: UITableViewController {

	convenience init() {
		self.init(nibName: nil, bundle: nil)
	}
	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

		title = "Repositories"
	}
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override func loadView() {
		super.loadView()
		
		tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: String(describing: RepoTableViewCell.self))
	}
	override func viewDidLoad() {
		super.viewDidLoad()

		let refreshControl = UIRefreshControl()

		refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: .valueChanged)
		tableView.refreshControl = refreshControl

		fetchRepositories()
	}

	@objc private func refreshControlAction(_ refreshControl: UIRefreshControl) {
		fetchRepositories()
		refreshControl.endRefreshing()
	}

	private var repositories = [GitHub.Repository]()

	private func fetchRepositories() {
		GitHub.handleRepositories(with: Handler<[GitHub.Repository], Error> { [weak self] result in
			switch result {
			case .failure(let error):
				debugPrint(error)

			case .success(let repositories):
				self?.repositories = repositories

				DispatchQueue.main.async {
					self?.tableView.reloadData()
				}
			}
		})
	}

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return repositories.count
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = self.tableView.dequeueReusableCell(withIdentifier: String(describing: RepoTableViewCell.self)) as! RepoTableViewCell
		let repo = repositories[indexPath.row]

		cell.repo = repo

		return cell
	}
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let repo = repositories[indexPath.row]
		let commitsViewController = CommitsViewController()

		commitsViewController.repo = repo
		navigationController?.pushViewController(commitsViewController, animated: true)
		tableView.deselectRow(at: indexPath, animated: true)
	}

}
