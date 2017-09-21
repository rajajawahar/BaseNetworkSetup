//
//  LoginResponse.swift
//  BaseNetworkSetup
//
//  Created by Raja Mohamed on 21/09/17.
//  Copyright © 2017 Raja Mohamed. All rights reserved.
//

import Foundation
import SwiftyJSON

struct LoginResponse {
    
    var token : String
    var message : String
    var status : Int
    var user : User
    
    
    init(json: JSON) {
        token = json["token"].stringValue
        message = json["message"].stringValue
        status = json["status"].intValue
        user = User(json: json["user"])
    }
    
    struct User {
        var company : String
        var email : String
        var firstName : String
        var mobileNumber : String
        var name : String
        
        init(json : JSON) {
            company = json["company"].stringValue
            email = json["email"].stringValue
            firstName = json["first_name"].stringValue
            mobileNumber = json["mobile"].stringValue
            name = json["name"].stringValue
        }
    }
}

