//
//  LoginPresenter.swift
//  BaseNetworkSetup
//
//  Created by rajamohamed on 12/09/17.
//  Copyright © 2017 Raja Mohamed. All rights reserved.
//

import Foundation
import RxSwift

class LoginPresenter : BasePresenter {
    

    typealias View = LoginView

    var userView : LoginView?
    let disposeBag = DisposeBag()

    
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
        APIManager.apiManager.loginWithRx(params: params).debug()
            .subscribe(onNext: { (loginRespone) in
                print(loginRespone.company)
                print(loginRespone.email)
                print(loginRespone.mobileNumber)
        }, onError: { (error) in
            print("onError")
        }, onCompleted: {
            print("onCompelete")
            }).disposed(by: disposeBag)
        

    

    }
    
    
}
