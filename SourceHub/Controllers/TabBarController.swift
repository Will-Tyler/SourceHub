//
//  TabBarController.swift
//  SourceHub
//
//  Created by Will Tyler on 3/27/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit


class TabBarController: UITabBarController {

	private lazy var feedNavigationController = UINavigationController(rootViewController: FeedViewController())
	private lazy var profileNavigationController = UINavigationController(rootViewController: ProfileViewController())

	override func viewDidLoad() {
		super.viewDidLoad()

		setViewControllers([feedNavigationController, profileNavigationController], animated: false)
	}

}
