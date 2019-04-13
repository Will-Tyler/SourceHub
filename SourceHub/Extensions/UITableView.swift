//
//  UITableView.swift
//  Kleene
//
//  Created by Will Tyler on 4/6/19.
//  Copyright © 2019 Kleene. All rights reserved.
//

import UIKit


extension UITableView {

	@inlinable
	func register(_ cellClass: AnyClass) {
		register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
	}

	@inlinable
	func dequeueReusableCell(ofType type: AnyClass, for indexPath: IndexPath) -> UITableViewCell {
		return dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath)
	}

}
