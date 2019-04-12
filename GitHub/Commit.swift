//
//  Commit.swift
//  SourceHub
//
//  Created by APPLE on 4/8/19.
//  Copyright © 2019 SourceHub. All rights reserved.
//

import Foundation

extension GitHub {
    
    struct Commit: Codable {

        let url: String
        let commit: InnerCommit
        let author: Author
        let committer: Committer
        let message: String

        private enum CodingKeys: String, CodingKey {
            case url
            case author
            case committer
            case message
            case commit
        }

    }
    
}

extension GitHub.Commit {
    
    struct InnerCommit: Codable {
        let url: String
        let author: CommitAuthor
        let committer: CommitCommitter
        let message: String
        
        private enum CodingKeys: String, CodingKey {
            case url
            case author
            case committer
            case message
        }
    }
    
    struct Author: Codable {
        let login: String
        let id: Int
        let avatar_url: String
        let events_url: URL
        let received_events_url: URL
    }
    
    struct Committer: Codable {
        let login: String
        let id: Int
        let avatar_url: String
        let events_url: URL
        let received_events_url: URL
    }
}

extension GitHub.Commit.InnerCommit {
    
    struct CommitAuthor: Codable {
        let name: String
        let email: String
        let date: String
    }
    
    struct CommitCommitter: Codable {
        let name: String
        let email: String
        let date: String
    }
    
}

