//
//  ReposViewController.swift
//  SourceHub
//
//  Created by Will Tyler on 4/5/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit


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
		
		tableView.register(RepoCell.self, forCellReuseIdentifier: String(describing: RepoCell.self))
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

	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return repositories.count
	}
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = self.tableView.dequeueReusableCell(withIdentifier: String(describing: RepoCell.self)) as! RepoCell
		let repo = repositories[indexPath.row]

		cell.repo = repo

		return cell
	}
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let repo = repositories[indexPath.row]
        let commitView = segue.destination as! CommitsTableViewController
        commitView.repo = repo
    }

}
