//
//  Comment.swift
//  Instargram
//
//  Created by TT Nguyen on 11/20/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

import UIKit

class CommentCell: BaseCell {
    
    var comments: Comments? {
        didSet {
            comment.text = comments?.comment
        }
    }
    
    var user: Users? {
        didSet {
            profileName.text = user?.username
            if let photoUrlString = user?.profile_image {
                let photoUrl = URL(string: photoUrlString)
                self.profileImage.sd_setImage(with: photoUrl, placeholderImage: #imageLiteral(resourceName: "Profile_Selected"))
            }
        }
    }

    let profileImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Profile_Selected")
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 15
        image.backgroundColor = .red
        image.clipsToBounds = true
        return image
    }()
    
    let profileName: UILabel = {
        let name = UILabel()
        name.text = "fsddsf"
        name.font = UIFont.boldSystemFont(ofSize: 12)
        return name
    }()
    
    let comment: UILabel = {
        let name = UILabel()
        name.numberOfLines = 0
        name.font = UIFont.systemFont(ofSize: 12)
        return name
    }()
    
    override func setupViews() {
        addSubview(profileImage)
        addSubview(profileName)
        addSubview(comment)
    
        addConstraintsWithForMat(format: "H:|-12-[v0(30)]-12-[v1]-12-|", views: profileImage, profileName)
        addConstraintsWithForMat(format: "V:|-15-[v0(30)]", views: profileImage)
        addConstraintsWithForMat(format: "V:|-12-[v0(20)]-8-[v1]-12-|", views: profileName, comment)
        addConstraintsWithForMat(format: "H:[v0]-12-|", views: comment)
        
        comment.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 12).isActive = true

    }

}
