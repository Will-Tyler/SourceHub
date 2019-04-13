//
//  Macro.swift
//  SourceHub
//
//  Created by Will Tyler on 3/29/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import Foundation
import AlamofireImage


// Use this file for global variables.

/// Use this to download images. This will automatically store them on the device.
let imageDownloader = ImageDownloader()


var topViewController: UIViewController? {
	get {
		if var viewController = UIApplication.shared.keyWindow?.rootViewController {
			while let presented = viewController.presentedViewController {
				viewController = presented
			}

			return viewController
		}
		else {
			return nil
		}
	}
}
