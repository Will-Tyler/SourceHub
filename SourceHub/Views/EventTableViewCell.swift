//
//  EventTableViewCell.swift
//  SourceHub
//
//  Created by Will Tyler on 4/3/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit


class EventTableViewCell: UITableViewCell {

	private lazy var avatarImageView: UIImageView = {
		let image = UIImageView()

		image.clipsToBounds = true
		image.contentMode = .scaleAspectFit
		image.layer.cornerRadius = 3

		return image
	}()
	private lazy var descriptionLabel: UILabel = {
		let label = UILabel()

		label.numberOfLines = 0

		return label
	}()

	private func setupInitialLayout() {
		let spacing = 12 as CGFloat

		addSubview(avatarImageView)
		addSubview(descriptionLabel)

		avatarImageView.translatesAutoresizingMaskIntoConstraints = false
		descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			avatarImageView.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: spacing),
			avatarImageView.centerYAnchor.constraint(equalTo: descriptionLabel.centerYAnchor),
			avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: spacing),
			avatarImageView.heightAnchor.constraint(equalToConstant: 32),
			avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),

			bottomAnchor.constraint(greaterThanOrEqualTo: avatarImageView.bottomAnchor, constant: spacing),

			descriptionLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: spacing),
			descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
			descriptionLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: spacing),
			descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -spacing),

			bottomAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor, constant: spacing)
		])
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		backgroundColor = .clear
	}

	private var didSetupInitialLayout = false
	var event: GitHubEvent! {
		didSet {
			let boldFont = UIFont.boldSystemFont(ofSize: UIFont.labelFontSize)

			if let pushEvent = event as? GitHub.PushEvent {
				let attributedMessage = NSMutableAttributedString()
				let boldDisplayLogin = NSAttributedString(string: pushEvent.actor.displayLogin, attributes: [.font: boldFont])
				let boldRepoName = NSAttributedString(string: pushEvent.repo.name, attributes: [.font: boldFont])

				attributedMessage.append(boldDisplayLogin)
				attributedMessage.append(NSAttributedString(string: " pushed to "))
				attributedMessage.append(boldRepoName)

				descriptionLabel.attributedText = attributedMessage

				pushEvent.actor.handleAvatarImage(with: Handler { result in
					DispatchQueue.main.async { [weak self] in
						self?.avatarImageView.image = try? result.get()
						self?.setNeedsLayout()
					}
				})
			}
			else if let watchEvent = event as? GitHub.WatchEvent {
				let attributedMessage = NSMutableAttributedString()
				let boldDisplayLogin = NSMutableAttributedString(string: watchEvent.actor.displayLogin, attributes: [.font: boldFont])
				let boldRepoName = NSAttributedString(string: watchEvent.repo.name, attributes: [.font: boldFont])

				attributedMessage.append(boldDisplayLogin)
				attributedMessage.append(NSAttributedString(string: " starred "))
				attributedMessage.append(boldRepoName)

				descriptionLabel.attributedText = attributedMessage

				watchEvent.actor.handleAvatarImage(with: Handler { result in
					DispatchQueue.main.async { [weak self] in
						self?.avatarImageView.image = try? result.get()
						self?.setNeedsLayout()
					}
				})
			}

			if !didSetupInitialLayout {
				setupInitialLayout()
				didSetupInitialLayout = true
			}
		}
	}

}
