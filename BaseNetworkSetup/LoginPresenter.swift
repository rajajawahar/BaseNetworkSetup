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
  
    
    
}
