//
//  APIManager.swift
//  BaseNetworkSetup
//
//  Created by rajamohamed on 12/09/17.
//  Copyright © 2017 Raja Mohamed. All rights reserved.
//


import Foundation
import SwiftyJSON
import Alamofire
import UIKit

class APIManager   {
    
    
    func login(username: String,passwd: String,
               callback: @escaping (String?, JSON?) -> Void) -> Operation {
        let params: [String:String] = ["loginid":"~eq~"+username, "_format":"json", "_compact":"1"]
        return callServer(.get, urlString: APIConstants.LOGIN_URL,
                          params: params,callback: callback)
    }
    
    
    fileprivate func callServer(_ method: Alamofire.HTTPMethod,
                                urlString: String,
                                params: [String: String],
                                callback: @escaping (String?, JSON?) -> Void) -> Operation {
        return APIOperation(method: method,urlString: urlString,params: params,callback:callback).execute()
        
    }
}



