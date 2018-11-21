//
//  Comment.swift
//  Instargram
//
//  Created by TT Nguyen on 11/20/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import SVProgressHUD

class Comment: UIViewController, UITableViewDataSource {
    
    let postId = "-LRQxAeJBk53BeNNDJCi"
    var comments = [Comments]()
    var users = [Users]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCellId", for: indexPath) as! CommentCell
        let user = users[indexPath.row]
        let comment = comments[indexPath.row]
        cell.user = user
        cell.comments = comment
        return cell
    }
    
    let commentTextField: UITextField = {
        let text = UITextField()
        text.placeholder = "Write a comment..."
        return text
    }()
    
    let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.isEnabled = false
        button.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        button.setTitleColor(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(sendHandle), for: .touchUpInside)
        return button
    }()
    
    let commentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    let lineSpacing: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return view
    }()
    
    fileprivate func loadComments() {
        SVProgressHUD.setBackgroundColor(.clear)
        let postCommentRef = Database.database().reference().child("post-comments").child(self.postId)
        postCommentRef.observe(.childAdded) { (snapShot) in
            let commentRef = Database.database().reference().child("comments").child(snapShot.key)
            commentRef.observeSingleEvent(of: .value, with: { (snapShotComment) in
                if let dictionary = snapShotComment.value as? NSDictionary {
                    print(dictionary)
                    let newComment = Comments.transformComments(dictionary: dictionary)
                    self.fetchUser(uid: (Auth.auth().currentUser?.uid)!, completed: {
                        self.comments.append(newComment)
                        self.tableView.reloadData()
                    })
                }
            })
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
    
    @objc fileprivate func sendHandle() {
        let ref = Database.database().reference()
        let commentRef = ref.child("comments")
        let newCommentId = commentRef.childByAutoId().key
        let newCommentRef = commentRef.child(newCommentId!)
        guard let currentUser = Auth.auth().currentUser  else {
            return
        }
        let currentId = currentUser.uid
        newCommentRef.setValue(["uid": currentId, "comment": commentTextField.text!]) { (error, refs) in
            if error != nil {
                SVProgressHUD.showError(withStatus: error?.localizedDescription)
                return
            }
            let postComment = ref.child("post-comments").child(self.postId).child(newCommentId!)
            postComment.setValue(true, withCompletionBlock: { (error, ref) in
                if error != nil {
                    SVProgressHUD.showError(withStatus: error?.localizedDescription)
                    return
                }
            })
            self.empty()
            
        }
    }
    
    fileprivate func handleTextField() {
        commentTextField.addTarget(self, action: #selector(handleTextFieldDidChanged), for: .editingChanged)
       
    }
    
    @objc fileprivate func handleTextFieldDidChanged() {
        guard let comment = commentTextField.text, !comment.isEmpty else {
            sendButton.isEnabled = false
            return
        }
        sendButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        sendButton.isEnabled = true
    }
    
    fileprivate func empty() {
        commentTextField.text = ""
        sendButton.isEnabled = false
        sendButton.setTitleColor(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), for: .normal)
        
    }
    
    
    
    fileprivate func setupTableView() {
        tableView.estimatedRowHeight = 521
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.register(CommentCell.self, forCellReuseIdentifier: "commentCellId")
        
        view.addSubview(tableView)
        view.addSubview(commentView)
        view.addSubview(lineSpacing)
        commentView.addSubview(sendButton)
        commentView.addSubview(commentTextField)
        
        commentView.addConstraintsWithForMat(format: "H:|-12-[v0]-8-[v1(60)]-8-|", views: commentTextField, sendButton)
        commentView.addConstraintsWithForMat(format: "V:|-12-[v0(30)]", views: commentTextField)
        commentView.addConstraintsWithForMat(format: "V:|-12-[v0(30)]", views: sendButton)
        
        view.addConstraintsWithForMat(format: "H:|[v0]|", views: tableView)
        view.addConstraintsWithForMat(format: "H:|[v0]|", views: commentView)
        view.addConstraintsWithForMat(format: "H:|[v0]|", views: lineSpacing)
        view.addConstraintsWithForMat(format: "V:|[v0][v2(0.5)][v1(80)]|", views: tableView, commentView, lineSpacing)
    }
    
    @objc fileprivate func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "Comment"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-back-30"), style: .done, target: self, action: #selector(handleDismiss))
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        setupTableView()
        handleTextField()
        loadComments()
        
    }
    
    
}
