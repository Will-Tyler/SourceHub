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

		label.font = UIFont.systemFont(ofSize: 12)
		label.numberOfLines = 1

		return label
	}()
    
    static let cellID = "RepoTableViewCell"
    
    var repo: GitHub.Repository! {
        didSet {
            repoLabel.text = repo.name

			if !didSetupInitialLayout {
				setupInitialLayout()
			}
        }
    }

	private var didSetupInitialLayout = false
    private func setupInitialLayout() {
        addSubview(repoLabel)

        repoLabel.translatesAutoresizingMaskIntoConstraints = false
		repoLabel.heightAnchor.constraint(equalToConstant: repoLabel.intrinsicContentSize.height).isActive = true
		repoLabel.widthAnchor.constraint(equalToConstant: repoLabel.intrinsicContentSize.height).isActive = true
        repoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        repoLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

		didSetupInitialLayout = true
    }

}
