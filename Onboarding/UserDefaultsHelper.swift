//
//  UserDefaultsHelper.swift
//  Onboarding
//
//  Created by Zone 3 on 4/14/17.
//  Copyright © 2017 Zone 3. All rights reserved.
//

import Foundation

extension UserDefaults{

    enum UserDefaultsKeys : String {
        case isLoggedIn
    }
    
    
    func setIsLoggedIn(value : Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        synchronize()
    }
    
    func getIsLoggedIn() -> Bool{
       return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }

}
