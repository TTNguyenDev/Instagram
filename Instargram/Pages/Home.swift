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

class Home: UIViewController, UITableViewDataSource {
    
    var posts = [Posts]()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.post = post
        return cell
    }
    
    fileprivate func loadPost() {
        Database.database().reference().child("posts").observe(.childAdded) { (snapShot) in
            if let dictionary = snapShot.value as? NSDictionary {
                let newPost = Posts.transformPostPhoto(dictionary: dictionary)
                self.posts.append(newPost)
                self.tableView.reloadData()
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
    }
}



