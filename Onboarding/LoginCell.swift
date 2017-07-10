//
//  LoginCell.swift
//  Onboarding
//
//  Created by Zone 3 on 4/13/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import UIKit

class LoginCell: UICollectionViewCell {
    
    let logoImageView : UIImageView = {
        let image = UIImage(named: "logo")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    let emailTextField : UITextField = {
        let textField = LeftPaddingTextField()
        textField.placeholder = "Enter Email"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    let passwordTextField : UITextField = {
        let textField = LeftPaddingTextField()
        textField.placeholder = "Enter Password"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        return textField
    }()
    
    
    
    lazy var registerBottom : UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
       return button
    }()
    
    
    var delegate : LoginViewControllerDelegate?
    
    func handleRegister(){
        delegate?.finishRegister() 
        
    }
    override init(frame: CGRect) {
        super.init(frame : frame)
        addSubview(logoImageView)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(registerBottom)
        
        _ = logoImageView.anchor(centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -200, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 160, heightConstant: 160)
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        _ = emailTextField.anchor(logoImageView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 160, heightConstant: 50)
        _ = passwordTextField.anchor(emailTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 8, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 160, heightConstant: 50)
        
        _ = registerBottom.anchor(passwordTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 32, leftConstant: 32, bottomConstant: 0, rightConstant: 32, widthConstant: 160, heightConstant: 50)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LeftPaddingTextField : UITextField{

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
}
