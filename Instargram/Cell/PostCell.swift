//
//  PostCell.swift
//  Instargram
//
//  Created by TT Nguyen on 11/17/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

import UIKit
import SDWebImage
import FirebaseDatabase
import FirebaseAuth

class PostCell: BaseCell {
    
    var post: Posts? {
        didSet {
            captionForPost.text = post?.caption
            if let photoUrlString = post?.imageUrl {
                let photoUrl = URL(string: photoUrlString)
                imagePost.sd_setImage(with: photoUrl, placeholderImage: #imageLiteral(resourceName: "Placeholder-image"))
            }
            setupUserInfor()
        }
    }
    
    fileprivate func setupUserInfor() {
        if let uid = Auth.auth().currentUser?.uid {
            Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapShot) in
                  if let dictionary = snapShot.value as? NSDictionary {
                    let user = Users.transformUser(dictionary: dictionary)
                    self.profileName.text = user.username
                    if let photoUrlString = user.profile_image {
                        let photoUrl = URL(string: photoUrlString)
                        self.profileImage.sd_setImage(with: photoUrl, placeholderImage: #imageLiteral(resourceName: "Profile_Selected"))
                    }
                }
            }
        }
    }
    

    let profileImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "blur-wallpapers-55342-6592718")
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 17
        image.clipsToBounds = true
        return image
    }()
    
    let profileName: UILabel = {
        let name = UILabel()
        name.text = "Nguyễn Trọng Triết"
        name.font = UIFont.boldSystemFont(ofSize: 12)
        return name
    }()
    
    let imagePost: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    let like: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "like")
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    let comment: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Comment")
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    let share: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "share")
        image.contentMode = .scaleToFill
        image.clipsToBounds = true
        return image
    }()
    
    let lineSpacing: UIView = {
        let line = UIView()
        line.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return line
    }()
    
    let countLike: UIButton = {
        let button = UIButton()
        button.setTitle("Be the first like this", for: .normal)
        button.titleLabel?.font =  .boldSystemFont(ofSize: 10)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let captionForPost: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    override func setupViews() {
        addSubview(profileImage)
        addSubview(profileName)
        addSubview(imagePost)
        addSubview(like)
        addSubview(comment)
        addSubview(share)
        addSubview(lineSpacing)
        addSubview(countLike)
        addSubview(captionForPost)
        
        addConstraintsWithForMat(format: "V:|-12-[v0(34)]-12-[v1(300)]-12-[v2(20)]-12-[v3(10)]-12-[v4]-12-|", views: profileImage, imagePost, like, countLike, captionForPost)
        addConstraintsWithForMat(format: "V:|-12-[v0(30)]", views: profileName)
        addConstraintsWithForMat(format: "H:[v0]-8-|", views: profileName)
        addConstraintsWithForMat(format: "H:|-8-[v0(34)]", views: profileImage)
        addConstraintsWithForMat(format: "H:|[v0]|", views: imagePost)
        addConstraintsWithForMat(format: "H:|-12-[v0(20)]-18-[v1(20)]-18-[v2(20)]", views: like, comment, share)
        addConstraintsWithForMat(format: "H:|-8-[v0]", views: countLike)
        addConstraintsWithForMat(format: "H:|-8-[v0]-8-|", views: captionForPost)
        
        profileName.bottomAnchor.constraint(equalTo: imagePost.topAnchor, constant: -12).isActive = true
        profileName.leftAnchor.constraint(equalTo: profileImage.rightAnchor, constant: 8).isActive = true
        
        comment.topAnchor.constraint(equalTo: imagePost.bottomAnchor, constant: 12).isActive = true
        comment.bottomAnchor.constraint(equalTo: countLike.topAnchor, constant: -12).isActive = true
        
        share.topAnchor.constraint(equalTo: imagePost.bottomAnchor, constant: 12).isActive = true
        share.bottomAnchor.constraint(equalTo: countLike.topAnchor, constant: -12).isActive = true
    }
}
