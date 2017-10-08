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
import RxSwift

class APIManager : NSObject  {
    
    
    
    
    static let apiManager = APIManager()
    typealias apitype = (responseObject: JSON?, error: String?)
    
    
    // Call with Observable
    func loginWithRx(params: [String:String]) -> Observable<LoginResponse.User>{
        return Observable.create({ (observer) -> Disposable in
            let header = ["Content-Type": "application/json"]
            Alamofire.request(APIConstants.SERVER, method: .post, parameters: params,encoding: JSONEncoding.default,headers:header).responseString(completionHandler: { (response) in
                switch response.result{
                case .success:
                    let loginResponse = LoginResponse(json: JSON.init(parseJSON: response.result.value!))
                    observer.onNext(loginResponse.user)
                    observer.onCompleted()
                case .failure:
                    observer.onError("Invalid Parameter" as! Error)
                }
            })
            return Disposables.create();
        })
    }
    
    
    
    func multipart(){
        
        let parameters = [
            "file_name": "swift_file.jpeg"
        ]
        
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
            }
        }, to:"http://sample.com/upload_img.php")
        { (result) in
            switch result{
            case .success(let upload, streamingFromDisk: _, streamFileURL: _):
                print(upload.responseJSON(completionHandler: { (response) in
                    print( response.result)
                    
                }))
                
                
                break
            case .failure(let encodingError):
                print(encodingError.localizedDescription)
                break
                
            }
            
            
        }
        
        func login(params: [String:String],completionHandler: @escaping (apitype) -> ()) -> Request {
            return makeApiCall(url: APIConstants.SERVER, params: params,
                               completionHandler : completionHandler)
        }
        
        func makeApiCall(url: String, params: [String : String],completionHandler: @escaping (_ responseObject: JSON?, _ error: String?) -> ()) -> Request {
            let header = ["Content-Type": "application/json"]
            let request = Alamofire.request(url, method: .post, parameters: params,encoding: JSONEncoding.default,headers:header).responseString(completionHandler: { (response) in
                switch response.result{
                case .success:
                    if let value = response.result.value {
                        if ( response.response!.statusCode >= 400 && response.response!.statusCode < 500) {
                            print(value)
                            completionHandler(nil,value)
                        } else {
                            print(response)
                            let json = JSON.init(parseJSON: value)
                            completionHandler(json,nil)
                        }
                    }
                case .failure :
                    if let errorStr = String(data: response.data!, encoding: String.Encoding.utf8) {
                        if errorStr.characters.count > 0 {
                            completionHandler(nil,errorStr)
                            NSLog(errorStr)
                        }
                        else {
                            completionHandler(nil,errorStr)
                        }
                    }
                }
            })
            return request
        }
        
        
        
        
        // Traditional Way of Network Call
        func login(params: [String:String],
                   callback: @escaping (String?, JSON?) -> Void)  {
            
            return callServer(.post, urlString: APIConstants.SERVER,
                              params: params,callback: callback)
        }
        
        func getUserdetails(callback: @escaping (String?, JSON?) -> Void)  {
            callServer(.get, urlString: APIConstants.LOGIN_URL,
                       params: [:],callback: callback)
        }
        
        func callServer(_ method: Alamofire.HTTPMethod,
                        urlString: String,
                        params: [String: String],
                        callback: @escaping (String?, JSON?) -> Void)  {
            let header = ["Content-Type": "application/json"]
            
            let request = Alamofire.request(urlString, method: method, parameters: params,encoding: JSONEncoding.default,headers:header)
            request.responseString( completionHandler: { (response) -> Void in
                switch response.result {
                case .success:
                    NSLog("Success");
                    if let value = response.result.value {
                        if ( response.response!.statusCode >= 400 && response.response!.statusCode < 500) {
                            print(value)
                            callback(value, nil)
                        } else {
                            print(response)
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
}




