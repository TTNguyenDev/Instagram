//
//  Posts.swift
//  Instargram
//
//  Created by TT Nguyen on 11/16/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

import Foundation

class Posts {
    var caption: String?
    var imageUrl: String?
}

extension Posts {
    static func transformPostPhoto(dictionary: NSDictionary) -> Posts {
        let post = Posts()
        post.caption = dictionary["caption"] as? String
        post.imageUrl = dictionary["photoUrl"] as? String
        return post
    }
}
