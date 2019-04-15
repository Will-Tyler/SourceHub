//
//  OverViewController.swift
//  SourceHub
//
//  Created by Will Tyler on 3/27/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit
import GitHub


class OverViewController: ViewController {

	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

		title = "Overview"
	}
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	private lazy var profileImageView = UIImageView()
	private lazy var nameLabel: UILabel = {
		let label = UILabel()

		label.font = .boldSystemFont(ofSize: 24)

		return label
	}()
	private lazy var loginLabel: UILabel = {
		let label = UILabel()

		label.font = UIFont.systemFont(ofSize: 20)
		label.textColor = .darkText

		return label
	}()
	private lazy var bioLabel: UILabel = {
		let label = UILabel()

		label.numberOfLines = 0
		label.textAlignment = .center

		return label
	}()

	private func setupInitialLayout() {
		view.addSubview(profileImageView)
		view.addSubview(nameLabel)
		view.addSubview(loginLabel)
		view.addSubview(bioLabel)

		let safeArea = view.safeAreaLayoutGuide

		profileImageView.translatesAutoresizingMaskIntoConstraints = false
		nameLabel.translatesAutoresizingMaskIntoConstraints = false
		loginLabel.translatesAutoresizingMaskIntoConstraints = false
		bioLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			profileImageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 32),
			profileImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
			profileImageView.heightAnchor.constraint(equalToConstant: 128),
			profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),

			nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 16),
			nameLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),

			loginLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
			loginLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),

			bioLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor),
			bioLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
			bioLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
			bioLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
		])
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setupInitialLayout()
		fetchUser()
	}

	private func fetchUser() {
		GitHub.handleAuthenticatedUser(with: Handler { [weak self] result in
			switch result {
			case .failure(let error):
				debugPrint(error)

			case .success(let user):
				DispatchQueue.main.async {
					self?.nameLabel.text = user.name
					self?.loginLabel.text = user.login
					self?.bioLabel.text = user.bio
				}

				imageDownloader.download(user.avatarURL, completion: { [weak self] response in
					self?.profileImageView.image = response.value
				})
			}
		})
	}

}
