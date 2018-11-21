//
//  Home.swift
//  Instargram
//
//  Created by TT Nguyen on 11/11/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

class Home: UIViewController, UITableViewDataSource {
    
    var posts = [Posts]()
    var users = [Users]()
    
   
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    @objc fileprivate func showCommentHandle() {
        let comment = UINavigationController(rootViewController: Comment())
        
        self.present(comment, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        let user = users[indexPath.row]
        cell.post = post
        cell.user = user
        return cell
    }
    
    fileprivate func loadPost() {
        SVProgressHUD.show()
        SVProgressHUD.setBackgroundColor(.clear)
        Database.database().reference().child("posts").observe(.childAdded) { (snapShot) in
            print(snapShot.value)
            if let dictionary = snapShot.value as? NSDictionary {
                let newPost = Posts.transformPostPhoto(dictionary: dictionary)
                self.fetchUser(uid: (Auth.auth().currentUser?.uid)!, completed: {
                    self.posts.append(newPost)
                    SVProgressHUD.dismiss()
                    self.tableView.reloadData()
                })
            }
        }
    }
    
    fileprivate func fetchUser(uid: String,completed: @escaping () -> Void) {
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapShot) in
            if let dictionary = snapShot.value as? NSDictionary {
                let user = Users.transformUser(dictionary: dictionary)
                self.users.append(user)
                completed()
            }
        }
    }
    
    fileprivate func setupTableView() {
        tableView.estimatedRowHeight = 521
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.register(PostCell.self, forCellReuseIdentifier: "cellId")
    
        view.addSubview(tableView)
   
        view.addConstraintsWithForMat(format: "H:|[v0]|", views: tableView)
        view.addConstraintsWithForMat(format: "V:|[v0]|", views: tableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPost()
        setupTableView()
        
         navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Comment", style: .done, target: self, action: #selector(showCommentHandle))
        
        
    }
}



