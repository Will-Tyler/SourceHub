//
//  ContentsViewController.swift
//  SourceHub
//
//  Created by APPLE on 4/15/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit
import GitHub

class ContentsViewController: UITableViewController {
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        title = "Contents"
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var repo: GitHub.Repository?
    var contents = [GitHub.Content]()
    var path = "";

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchContents()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let content = self.contents[indexPath.row]
        cell.textLabel?.text = "Type: \(content.type)   Name: \(content.name)"
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func fetchContents(path: String? = "") {
        guard let repo = self.repo else { return }
        
        GitHub.handleContents(owner: repo.owner.login, repo: repo.name, path: path, with: Handler{ [weak self] result in
            switch result {
            case .failure(let error):
                debugPrint(error)
                
            case .success(let contents):
                self?.contents = contents
                
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let content = self.contents[indexPath.row]
        if (content.type == "dir") {
            path += "/\(content.name)"
            fetchContents(path: path)
        } else {
            let webView = WebViewController()
            
            webView.url = content.download_url!.absoluteString
            navigationController?.pushViewController(webView, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
