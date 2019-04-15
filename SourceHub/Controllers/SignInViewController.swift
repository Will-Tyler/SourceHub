//
//  SignInViewController.swift
//  SourceHub
//
//  Created by Will Tyler on 3/5/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit
import GitHub


class SignInViewController: ViewController {

	private lazy var signInButton: UIButton = {
		let button = UIButton(type: .system)

		button.setTitle("Sign In", for: .normal)
		button.layer.cornerRadius = 10
		button.backgroundColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1)
		button.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		button.titleLabel?.font = UIFont.systemFont(ofSize: 32)
		button.addTarget(self, action: #selector(signInButtonAction), for: .touchUpInside)

		return button
	}()

	private lazy var signInImageView: UIImageView = {
		let image = UIImageView()

		image.image = UIImage(named: "SourceHub")!

		return image
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		view.addSubview(signInButton)
		view.addSubview(signInImageView)

		signInButton.translatesAutoresizingMaskIntoConstraints = false
		signInButton.heightAnchor.constraint(equalToConstant: signInButton.intrinsicContentSize.height + 16).isActive = true
		signInButton.widthAnchor.constraint(equalToConstant: signInButton.intrinsicContentSize.width + 32).isActive = true
		signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		signInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

		signInImageView.translatesAutoresizingMaskIntoConstraints = false
		signInImageView.heightAnchor.constraint(equalToConstant: signInButton.intrinsicContentSize.height + 16).isActive = true
		signInImageView.widthAnchor.constraint(equalToConstant: signInButton.intrinsicContentSize.width + 32).isActive = true
		signInImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		signInImageView.bottomAnchor.constraint(equalTo: signInButton.topAnchor, constant: -16).isActive = true
	}

	@objc private func signInButtonAction() {
		GitHub.initiateAuthentication(completion: { [weak self] error in
			if let error = error {
				debugPrint(error)
				self?.alertUser(title: "Authentication Error", message: error.localizedDescription)
			}
			else {
				self?.dismiss(animated: true)
			}
		})
	}

}

