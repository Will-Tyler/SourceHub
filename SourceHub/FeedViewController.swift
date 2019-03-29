//
//  FeedViewController.swift
//  SourceHub
//
//  Created by Will Tyler on 3/27/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit


class FeedViewController: ViewController {

	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

		title = "Feed"
	}
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		GitHub.handleReceivedEvents(with: { (events, error) in
			if let error = error {
				debugPrint(error)
			}
			else if let events = events {
				for event in events {
					print(event.id)
				}
			}
		})
	}

}
