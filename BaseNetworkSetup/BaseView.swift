//
//  BaseView.swift
//  BaseNetworkSetup
//
//  Created by rajamohamed on 14/09/17.
//  Copyright © 2017 Raja Mohamed. All rights reserved.
//

import Foundation

protocol BaseView {
    
    func showLoading()
    
    func hideLoading();
    
    func showRetry();
    
    func hideRetry();
    
    func showError(message : String)
    
}
