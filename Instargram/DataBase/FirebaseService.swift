//
//  FirebaseService.swift
//  Instargram
//
//  Created by TT Nguyen on 11/14/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class FirebaseService {
    
    static func signIn(email: String, password: String, onFailed: @escaping (String) -> Void, onSuccess: @escaping () -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                onFailed(error!.localizedDescription)
                return
            }
            onSuccess()
        }
    }
    
    static func signUp(email: String, password: String, onFailed: @escaping (String) -> Void, onSuccess: @escaping () -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                onFailed(error!.localizedDescription)
                return
            }
            onSuccess()
        }
    }
}


