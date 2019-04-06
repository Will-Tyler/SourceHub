//
//  ImageDownloader.swift
//  SourceHub
//
//  Created by Will Tyler on 4/5/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import AlamofireImage


extension ImageDownloader {

	@inlinable @discardableResult
	func download(_ url: URL, completion: ImageDownloader.CompletionHandler? = nil) -> RequestReceipt? {
		return download(URLRequest(url: url), completion: completion)
	}

}
