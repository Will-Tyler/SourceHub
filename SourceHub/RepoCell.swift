//
//  RepoCell.swift
//  SourceHub
//
//  Created by APPLE on 3/28/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {
    
    static let cellID = "RepoTableViewCell"
    
    var repo: GitHub.Repository! {
        didSet {
            repoLabel.text = repo.name as String
            setupInitialLayout()
        }
    }
    
    private lazy var repoLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        
        return label
    }()
    
    private func setupInitialLayout() {
        addSubview(repoLabel)
        repoLabel.translatesAutoresizingMaskIntoConstraints = false
        repoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        repoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
