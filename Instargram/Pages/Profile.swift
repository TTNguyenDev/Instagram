//
//  Profile.swift
//  Instargram
//
//  Created by TT Nguyen on 11/11/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

import UIKit
import FirebaseAuth

class Profile: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icons8-logout-rounded-left-26"), style: .done, target: self, action: #selector(logoutHandle))
       

    }
    
    @objc fileprivate func logoutHandle() {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        let vc = SignIn()
        self.present(vc, animated: true, completion: nil)
    }
    

}
