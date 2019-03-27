//
//  UIViewController.swift
//  Kleene
//
//  Created by Will Tyler on 2/6/19.
//  Copyright © 2019 Kleene. All rights reserved.
//

import UIKit


extension UIViewController {

	func alertUser(title: String, message: String) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

		alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))

		present(alertController, animated: true)
	}

}
