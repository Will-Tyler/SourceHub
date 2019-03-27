//
//  SignInViewController.swift
//  SourceHub
//
//  Created by Will Tyler on 3/5/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit


class SignInViewController: ViewController {

	private lazy var signInButton: UIButton = {
		let button = UIButton(type: .system)

		button.setTitle("Sign In", for: .normal)
		button.addTarget(self, action: #selector(signIn), for: .touchUpInside)

		return button
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		view.addSubview(signInButton)

		signInButton.translatesAutoresizingMaskIntoConstraints = false
		signInButton.heightAnchor.constraint(equalToConstant: signInButton.intrinsicContentSize.height).isActive = true
		signInButton.widthAnchor.constraint(equalToConstant: signInButton.intrinsicContentSize.width).isActive = true
		signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		signInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
	}

	@objc private func signIn() {
		GitHub.initiateAuthentication(completion: { error in
			if let error = error {
				self.alertUser(title: "Authentication Error", message: error.localizedDescription)
			}
			else {
				self.dismiss(animated: true)
			}
		})
	}

}

