//
//  ParamUtils.swift
//  BaseNetworkSetup
//
//  Created by Raja Mohamed on 21/09/17.
//  Copyright © 2017 Raja Mohamed. All rights reserved.
//

import Foundation

class ParamUtils {
    
    static func createLoginParams(username : String,password : String) ->[String: String] {
        return ["email":username,"password": password,"device_name":"Android"]
    }
}
