//
//  WebViewController.swift
//  SourceHub
//
//  Created by APPLE on 4/20/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit


class WebViewController: UIViewController {

	init(url: URL) {
		self.url = url
		super.init(nibName: nil, bundle: nil)
	}
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	private let url: URL
	private(set) var webView: UIWebView!

	override func loadView() {
		webView = UIWebView()
		view = webView
	}
	override func viewDidLoad() {
		super.viewDidLoad()

		webView.loadRequest(URLRequest(url: url))
	}

}
