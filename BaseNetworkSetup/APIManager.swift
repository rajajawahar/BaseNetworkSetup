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

class APIManager : NSObject  {
    
     static let apiManager = APIManager()

    
    func login(username: String,passwd: String,
               callback: @escaping (String?, JSON?) -> Void)  {
        let params: [String:String] = ["loginid":"~eq~"+username, "_format":"json", "_compact":"1"]
        return callServer(.get, urlString: APIConstants.LOGIN_URL,
                          params: params,callback: callback)
    }
    
    func getUserdetails(callback: @escaping (String?, JSON?) -> Void)  {
         callServer(.get, urlString: APIConstants.LOGIN_URL,
                          params: [:],callback: callback)
    }
    
    fileprivate func callServer(_ method: Alamofire.HTTPMethod,
                                urlString: String,
                                params: [String: String],
                                callback: @escaping (String?, JSON?) -> Void)  {
        let request = Alamofire.request(urlString, method: method, parameters: params)
        request.responseString( completionHandler: { (response) -> Void in
            switch response.result {
            case .success:
                NSLog("Success");
                if let value = response.result.value {
                    if ( response.response!.statusCode >= 400 && response.response!.statusCode < 500) {
                        print(value)
                        callback(value, nil)
                    } else {
                        let json = JSON.init(parseJSON: value)
                        callback(nil, json)
                    }
                } else {
                    callback("Error connecting to server", nil)
                }
                
            case .failure(let error):
                NSLog("Failure \(error)")
                if let errorStr = String(data: response.data!, encoding: String.Encoding.utf8) {
                    if errorStr.characters.count > 0 {
                        callback(errorStr, nil)
                        NSLog(errorStr)
                    }
                    else {
                        callback(error.localizedDescription,nil)
                    }
                } else {
                    callback("Error Connecting to Server", nil)
                }
            }
        })
    }

}



