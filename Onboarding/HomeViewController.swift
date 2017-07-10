//
//  HomeViewController.swift
//  Onboarding
//
//  Created by Zone 3 on 4/13/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(handleSignout))
        
        view.backgroundColor = .white
        
        let imageView: UIImageView = UIImageView(image: UIImage(named: "home"))
        view.addSubview(imageView)
        _ = imageView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 64, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    
    func handleSignout(){
        UserDefaults.standard.setIsLoggedIn(value: false)
        let logincontroller = LoginViewController()
        present(logincontroller, animated: true, completion: nil)
    }

    
}
