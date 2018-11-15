//
//  Photos.swift
//  Instargram
//
//  Created by TT Nguyen on 11/11/18.
//  Copyright © 2018 TT Nguyen. All rights reserved.
//

import UIKit

class Photos: UIViewController {
    
    let image: UIImageView  = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Placeholder-image")
        image.layer.cornerRadius = 40
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
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
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)
        button.addTarget(self, action: #selector(shareHandle), for: .touchUpInside)
        return button
    }()

    @objc fileprivate func shareHandle() {
        print (status.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    fileprivate func setupViews() {
        view.addSubview(statusView)
        view.addSubview(shareButton)
        statusView.addSubview(image)
        statusView.addSubview(status)
        
        view.addConstraintsWithForMat(format: "H:|-8-[v0]-8-|", views: shareButton)
        view.addConstraintsWithForMat(format: "V:[v0(50)]-90-|", views: shareButton)
        
        statusView.addConstraintsWithForMat(format: "H:|-20-[v0(80)]-20-[v1]-20-|", views: image, status)
        statusView.addConstraintsWithForMat(format: "V:|-40-[v0]-40-|", views: image)
        statusView.addConstraintsWithForMat(format: "V:|-30-[v0]-30-|", views: status)
        
        view.addConstraintsWithForMat(format: "H:|-8-[v0]-8-|", views: statusView)
        view.addConstraintsWithForMat(format: "V:|-100-[v0(\(view.frame.height/5))]", views: statusView)
    }
}
