//
//  ViewController.swift
//  Instargram
//
//  Created by TT Nguyen on 11/11/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

import UIKit

class SignUp: UIViewController {
    
    let ProfileImageName: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "1457604267")
        image.contentMode = .scaleToFill
        image.layer.cornerRadius = 40
        image.clipsToBounds = true
        return image
    }()
    
    let UserName: UITextField = {
        let textField = UITextField()
        textField.placeholder = "  Name"
        textField.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        textField.layer.cornerRadius = 9
        textField.clipsToBounds = true
        return textField
    }()
    
    let Email: UITextField = {
        let textField = UITextField()
        textField.placeholder = "  Email"
        textField.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        textField.layer.cornerRadius = 9
        textField.clipsToBounds = true
        return textField
    }()
    
    let Password: UITextField = {
        let textField = UITextField()
        textField.placeholder = "  Password"
        textField.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        textField.layer.cornerRadius = 9
        textField.clipsToBounds = true
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let SignUpButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(signUpHandle), for: .touchUpInside)
        return button
    }()
    
    let Name: UILabel = {
        let label = UILabel()
        label.text = "INSTAGRAM"
        label.textColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 35)
        return label
    }()
    
    
    
    @objc fileprivate func signUpHandle() {
        let vc = TabSwitcher()
        present(vc, animated: true, completion: nil)
    }
    
    fileprivate func SetupViews() {
        view.addSubview(Email)
        view.addSubview(Password)
        view.addSubview(SignUpButton)
        view.addSubview(Name)
        view.addSubview(ProfileImageName)
        view.addSubview(UserName)
        
        view.addConstraintsWithForMat(format: "H:|-20-[v0]-20-|", views: Email)
        view.addConstraintsWithForMat(format: "H:|-20-[v0]-20-|", views: Password)
        view.addConstraintsWithForMat(format: "H:|-20-[v0]-20-|", views: SignUpButton)
        view.addConstraintsWithForMat(format: "H:|-20-[v0]-20-|", views: Name)
        view.addConstraintsWithForMat(format: "H:|-20-[v0]-20-|", views: UserName)
        view.addConstraintsWithForMat(format: "H:[v0(80)]", views: ProfileImageName)
        
        view.addConstraintsWithForMat(format: "V:[v3(50)]-25-[v5(80)]-25-[v4(30)]-20-[v0(30)]-20-[v1(30)]-20-[v2(40)]", views: Email, Password, SignUpButton, Name, UserName, ProfileImageName)
        
        Email.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20).isActive = true
        ProfileImageName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "blur-wallpapers-55342-6592718"))
        
        navigationController?.navigationBar.isHidden = true
        
        SetupViews()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
}

