//
//  RepoCell.swift
//  SourceHub
//
//  Created by APPLE on 3/28/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {

	private lazy var repoLabel: UILabel = {
		let label = UILabel()

		label.font = UIFont.systemFont(ofSize: 24)
		label.numberOfLines = 1
        label.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true

		return label
	}()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        
        return label
    }()
    
    static let cellID = "RepoTableViewCell"
    
    var repo: GitHub.Repository! {
        didSet {
            repoLabel.text = repo.name
            if (repo.description == nil) {
                descriptionLabel.text = "No description avail"
            } else {
                descriptionLabel.text = repo.description
            }
            
            if (!repo.isPrivate) {
                isPrivateImageView.image = UIImage(named: "Circle_Green")
            } else {
                isPrivateImageView.image = UIImage(named: "Circle_Red")
            }
            
			if !didSetupInitialLayout {
				setupInitialLayout()
			}
        }
    }
    
    private lazy var isPrivateImageView: UIImageView = {
        let image = UIImageView()
        
        return image
    }()
    
    lazy var owner: GitHub.Owner! = repo.owner

	private var didSetupInitialLayout = false
    private func setupInitialLayout() {
        let isPrivateLabel = UILabel()
        isPrivateLabel.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        isPrivateLabel.text = "Private"
        isPrivateLabel.layer.cornerRadius = 5
        isPrivateLabel.layer.masksToBounds = true
        
        addSubview(isPrivateLabel)
        addSubview(repoLabel)
        addSubview(isPrivateImageView)
        addSubview(descriptionLabel)

        repoLabel.translatesAutoresizingMaskIntoConstraints = false
		repoLabel.heightAnchor.constraint(equalToConstant: repoLabel.intrinsicContentSize.height).isActive = true
        repoLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
        repoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        repoLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.bottomAnchor.constraint(equalTo: isPrivateLabel.topAnchor, constant: -8).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: repoLabel.bottomAnchor, constant: 8).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        
        isPrivateLabel.translatesAutoresizingMaskIntoConstraints = false
        isPrivateLabel.heightAnchor.constraint(equalToConstant: isPrivateLabel.intrinsicContentSize.height).isActive = true
        isPrivateLabel.widthAnchor.constraint(equalToConstant: isPrivateLabel.intrinsicContentSize.width).isActive = true
        isPrivateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        isPrivateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
        
        isPrivateImageView.translatesAutoresizingMaskIntoConstraints = false
        isPrivateImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        isPrivateImageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        isPrivateImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        isPrivateImageView.leadingAnchor.constraint(equalTo: isPrivateLabel.trailingAnchor, constant: 8).isActive = true

		didSetupInitialLayout = true
    }

}
