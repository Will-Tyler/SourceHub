//
//  ProfileViewController.swift
//  SourceHub
//
//  Created by Will Tyler on 3/27/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit


class ProfileViewController: ViewController, UITableViewDataSource, UITableViewDelegate {

	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

		title = "Profile"
	}
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	private lazy var tableView: UITableView = {
		let table = UITableView()

		table.backgroundColor = .clear
		table.delegate = self
		table.dataSource = self
		table.register(RepoCell.self, forCellReuseIdentifier: String(describing: RepoCell.self))
		table.rowHeight = 150

		return table
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		let refreshControl = UIRefreshControl()

		refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: .valueChanged)
		tableView.addSubview(refreshControl)

		view.addSubview(tableView)

		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
		tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true

		let signOutItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOutItemAction))

		navigationItem.setRightBarButton(signOutItem, animated: false)

		fetchRepositories()
	}
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)
		fetchRepositories()
	}

	@objc private func refreshControlAction(_ refreshControl: UIRefreshControl) {
		fetchRepositories()
		refreshControl.endRefreshing()
	}
	@objc private func signOutItemAction() {
		GitHub.deauthenticate()
		tabBarController?.present(SignInViewController(), animated: true)
	}

	private var repositories = [GitHub.Repository]()

	private func fetchRepositories() {
		GitHub.handleRepositories(with: Handler { [weak self] result in
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

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return repositories.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = self.tableView.dequeueReusableCell(withIdentifier: String(describing: RepoCell.self)) as! RepoCell
		let repo = repositories[indexPath.row]

		cell.repo = repo

		return cell
	}

}
