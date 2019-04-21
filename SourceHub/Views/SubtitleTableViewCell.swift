//
//  SubtitleTableViewCell.swift
//  SourceHub
//
//  Created by Will Tyler on 4/21/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit


class SubtitleTableViewCell: UITableViewCell {

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
	}
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

}
