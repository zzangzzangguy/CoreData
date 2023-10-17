//
//  User.swift
//  ToDO
//
//  Created by t2023-m0096 on 2023/09/18.
//

import Foundation
import UIKit

struct User {
    let username: String
    let followersCount: Int
    let followingCount: Int
    let postCount: Int
    var FeedDataAr: [FeedData] = []
}
