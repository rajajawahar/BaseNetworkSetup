//
//  ViewController.swift
//  BaseNetworkSetup
//
//  Created by Raja Mohamed on 11/09/17.
//  Copyright © 2017 Raja Mohamed. All rights reserved.
//

import UIKit
import Alamofire



class LoginViewController: BaseViewController {
    
   let presenter = LoginPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(view: self as LoginView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter.detachView()
        
        
    }
    
 
}

extension LoginViewController : LoginView {
    
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func navigateToHome() {
    
    }
}

