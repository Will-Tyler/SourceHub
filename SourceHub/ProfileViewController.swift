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
    
    var repos = [GitHub.Repository]() {
        didSet {
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
        }
    }
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        
        table.backgroundColor = .clear
        table.delegate = self
        table.dataSource = self
        table.register(RepoCell.self, forCellReuseIdentifier: RepoCell.cellID)
        table.rowHeight = 150
        
        return table
    }()

	override func viewDidLoad() {
		super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: .valueChanged)
        
        getRepo()
        tableView.insertSubview(refreshControl, at: 0)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
		let signOutItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOutItemAction))

		navigationItem.setRightBarButton(signOutItem, animated: false)
	}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getRepo()
    }
    
    @objc private func refreshControlAction(_ refreshControl: UIRefreshControl) {
        getRepo()
        refreshControl.endRefreshing()
    }
    
    func getRepo() {
		GitHub.handleRepositories(with: { (repositories, error) in
			if let error = error {
				debugPrint(error)
			}
			else if let repositories = repositories {
				self.repos = repositories
			}
		})
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: RepoCell.cellID) as! RepoCell
        let repo = repos[indexPath.row]

        cell.repo = repo

        return cell
    }

	@objc private func signOutItemAction() {
		GitHub.deauthenticate()
		tabBarController?.present(SignInViewController(), animated: true)
	}

}
