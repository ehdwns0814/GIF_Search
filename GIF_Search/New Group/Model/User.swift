//
//  User.swift
//  GIF_Search
//
//  Created by 동준 on 5/20/24.
//

import Foundation

struct User {
    let name: String
    let displayName: String
    let description: String
    let avatarURL: String
}

extension User: Hashable { }
