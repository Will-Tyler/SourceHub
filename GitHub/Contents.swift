//
//  Contents.swift
//  SourceHub
//
//  Created by APPLE on 4/15/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import UIKit

public extension GitHub {

    struct Content: Codable {
        
        public let type: String
        public let size: Int
        public let name: String
        public let path: String
        public let url: URL
        public let download_url: URL?
        
    }
    
}
