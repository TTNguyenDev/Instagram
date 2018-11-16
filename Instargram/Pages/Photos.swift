//
//  Photos.swift
//  Instargram
//
//  Created by TT Nguyen on 11/11/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import SVProgressHUD

class Photos: UIViewController {
    
    var selectedImage: UIImage?
    
    let imagePicker: UIImageView  = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Placeholder-image")
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let status: UITextView = {
        let text = UITextView()
        text.backgroundColor = .clear
        text.font = .systemFont(ofSize: 20)
        text.textColor = #colorLiteral(red: 0.5058823824, green: 0.3372549117, blue: 0.06666667014, alpha: 1)
        text.autocapitalizationType = .sentences
        return text
    }()
    
    let statusView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        return view
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        button.addTarget(self, action: #selector(shareHandle), for: .touchUpInside)
        return button
    }()
    
    fileprivate func saveDataBase() {
        SVProgressHUD.show()
        let photoIdString = NSUUID().uuidString
        let storageRef = Storage.storage().reference(forURL: Config.STORAGE_ROOT_REF).child("posts").child(photoIdString)
        let metaDataForImage = StorageMetadata()
        metaDataForImage.contentType = "image/jpeg"
        
        if let profileImg = self.selectedImage {
            storageRef.putData(profileImg.jpegData(compressionQuality: 0.1)!, metadata: metaDataForImage) { (metaData, error) in
                if error != nil {
                    SVProgressHUD.showError(withStatus: error!.localizedDescription)
                    return
                }
                
                 _ = storageRef.downloadURL(completion: { (url, error) in
                    if error != nil {
                    SVProgressHUD.showError(withStatus: error!.localizedDescription)
                    return
                    }
                    let profileImageUrl = url?.absoluteString
                    let ref = Database.database().reference()
                    let postReference = ref.child("posts")
                    let newPostId = postReference.childByAutoId().key
                    let newPostReference = postReference.child(newPostId!)
                    newPostReference.setValue(["photoUrl": profileImageUrl, "caption": self.status.text!], withCompletionBlock: { (error, ref) in
                        if error != nil {
                            SVProgressHUD.showError(withStatus: error!.localizedDescription)
                            return
                        }
                        SVProgressHUD.showSuccess(withStatus: "Success")
                        self.clean()
                    })
                })
            }
        }
    }

    @objc fileprivate func shareHandle() {
        saveDataBase()
    }
    
    @objc fileprivate func handleSelectImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    @objc fileprivate func cancelHandle() {
        clean()
    }
    
    fileprivate func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSelectImage))
        imagePicker.addGestureRecognizer(tapGesture)
        imagePicker.isUserInteractionEnabled = true
    }
    
    fileprivate func clean() {
        imagePicker.image = #imageLiteral(resourceName: "Placeholder-image")
        selectedImage = nil
        status.text = ""
        handlePost()
    }
    
    fileprivate func handlePost() {
        if selectedImage != nil {
            shareButton.isEnabled = true
            self.navigationItem.leftBarButtonItem!.isEnabled = true
            shareButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        } else {
            shareButton.isEnabled = false
            self.navigationItem.leftBarButtonItem!.isEnabled = false
            shareButton.setTitleColor(#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1), for: .normal)
        }
    }
    
    fileprivate func setupNavigationItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Remove", style: .done, target: self, action: #selector(cancelHandle))
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavigationItem()
        setupTapGesture()
        
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handlePost()
    }
    
    fileprivate func setupViews() {
        view.addSubview(statusView)
        view.addSubview(shareButton)
        statusView.addSubview(imagePicker)
        statusView.addSubview(status)
        
        view.addConstraintsWithForMat(format: "H:|-8-[v0]-8-|", views: shareButton)
        view.addConstraintsWithForMat(format: "V:[v0(50)]-95-|", views: shareButton)
        
        statusView.addConstraintsWithForMat(format: "H:|-20-[v0(120)]-20-[v1]-20-|", views: imagePicker, status)
        statusView.addConstraintsWithForMat(format: "V:|-20-[v0]-20-|", views: imagePicker)
        statusView.addConstraintsWithForMat(format: "V:|-20-[v0]-20-|", views: status)
        
        view.addConstraintsWithForMat(format: "H:|-8-[v0]-8-|", views: statusView)
        view.addConstraintsWithForMat(format: "V:|-100-[v0(\(view.frame.height/6))]", views: statusView)
    }
}

extension Photos: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            selectedImage = image
            imagePicker.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
