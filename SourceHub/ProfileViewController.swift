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
        table.register(UITableViewCell.self, forCellReuseIdentifier: RepoCell.cellID)
        
        return table
    }()

	override func viewDidLoad() {
		super.viewDidLoad()
        
        getRepo()
        
		let signOutItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOutItemAction))

		navigationItem.setRightBarButton(signOutItem, animated: false)
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
