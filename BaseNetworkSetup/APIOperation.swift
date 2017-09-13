//
//  APIRepo.swift
//  BaseNetworkSetup
//
//  Created by rajamohamed on 12/09/17.
//  Copyright © 2017 Raja Mohamed. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIOperation : NSObject  {
    
    let method : Alamofire.HTTPMethod
    let params : [String: String]
    let urlString : String
    let callback : (String?, JSON?)

    
    
    init(method: Alamofire.HTTPMethod,
         urlString: String,
         params: [String: String],
         callback : (String?, JSON?)) {
        self.method = method
        self.urlString = urlString
        self.params = params
        self.callback = callback
    }
    
    
    func execute() -> (String?, JSON?){
       let request = Alamofire.request(urlString, method: method, parameters: params)
        request.responseString( completionHandler: { (response) -> Void in
            switch response.result {
            case .success:
                NSLog("Success");
                if let value = response.result.value {
                    if ( response.response!.statusCode >= 400 && response.response!.statusCode < 500) {
                        print(value)
                        return callback(value, nil)
                    } else {
                        let json = JSON.init(parseJSON: value)
                        return callback(nil, json)
                    }
                } else {
                    return callback("Error connecting to server", nil)
                }
                
            case .failure(let error):
                NSLog("Failure \(error)")
                if let errorStr = String(data: response.data!, encoding: String.Encoding.utf8) {
                    if errorStr.characters.count > 0 {
                        return callback(errorStr, nil)
                        NSLog(errorStr)
                    }
                    else {
                       return callback(error.localizedDescription,nil)
                    }
                } else {
                    return callback("Error Connecting to Server", nil)
                }
            }
        })
    }
    
    
}
