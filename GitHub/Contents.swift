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
        
        var type: String
        var size: Int
        var name: String
        var path: String
        var content: String
        var url: URL
        
    }
}
