//
//  File.swift
//  Instargram
//
//  Created by TT Nguyen on 11/19/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

import Foundation

class Users {
    var email: String?
    var profile_image: String?
    var username: String?
}

extension Users {
    static func transformUser(dictionary: NSDictionary) -> Users {
        let user = Users()
        user.email = dictionary["email"] as? String
        user.profile_image = dictionary["profile_image"] as? String
        user.username = dictionary["username"] as? String
        
        return user
    }
}
