//
//  Posts.swift
//  Instargram
//
//  Created by TT Nguyen on 11/16/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

import Foundation

class Posts {
    var caption: String
    var imageUrl: String
    
    init(captionText: String, imageUrlString: String) {
        caption = captionText
        imageUrl = imageUrlString
    }
}
