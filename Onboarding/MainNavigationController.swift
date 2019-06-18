//
//  MainNavigationController.swift
//  Onboarding
//
//  Created by Zone 3 on 4/13/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

       view.backgroundColor = .white
       
        
        
        if UserDefaults.standard.getIsLoggedIn(){
            let homeController = HomeViewController()
            viewControllers = [homeController]
        
        }else{
            perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
        }
    }
    
    @objc func showLoginController(){
        
        let loginController = LoginViewController()
        present(loginController, animated: true) {
            
        }
    
    }

    
}
