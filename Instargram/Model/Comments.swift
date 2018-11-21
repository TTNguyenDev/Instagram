//
//  Comment.swift
//  Instargram
//
//  Created by TT Nguyen on 11/20/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

import Foundation

class Comments {
    var comment: String?
    var uid: String?
}

extension Comments {
    static func transformComments(dictionary: NSDictionary) -> Comments {
        let comment = Comments()
        comment.comment = dictionary["comment"] as? String
        return comment
    }
}

