//
//  WebViewController.swift
//  SourceHub
//
//  Created by APPLE on 4/20/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    var url: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = UIWebView()
        view = webView
        
        let url = URL(string: self.url)!
        webView.loadRequest(URLRequest(url: url))
        
    }

}
