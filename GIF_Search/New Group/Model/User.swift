//
//  User.swift
//  GIF_Search
//
//  Created by 동준 on 5/20/24.
//

import Foundation

struct User {
    let name: String
    let profileURL: String
    let displayName: String
}

extension User: Hashable { }
