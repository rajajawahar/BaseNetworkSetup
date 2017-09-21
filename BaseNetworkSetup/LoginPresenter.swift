//
//  LoginPresenter.swift
//  BaseNetworkSetup
//
//  Created by rajamohamed on 12/09/17.
//  Copyright © 2017 Raja Mohamed. All rights reserved.
//

import Foundation

class LoginPresenter : BasePresenter {
    

    typealias View = LoginView

    var userView : LoginView?
    
    
    func attachView(view: LoginView) {
        userView = view
    }
    
    func detachView() {
        
    }
    
    func destroy() {
        
    }
    init() {

    }
  
    func signIn(userName : String,password: String)  {
        userView?.showLoading()
        let params = ParamUtils.createLoginParams(username: userName,password: password)
        APIManager.apiManager.login(params: params) { (error, response) in
            self.userView?.hideLoading()
            
            let user = LoginResponse(json: response!)
            print(user.user.company)
        
        }

    

    }
    
    
}
