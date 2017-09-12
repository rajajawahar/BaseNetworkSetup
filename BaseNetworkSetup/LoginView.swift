//
//  BaseView.swift
//  BaseNetworkSetup
//
//  Created by rajamohamed on 12/09/17.
//  Copyright © 2017 Raja Mohamed. All rights reserved.
//

import Foundation

protocol LoginView: NSObjectProtocol {
    
    func showLoading()
    func hideLoading()
    func navigateToHome()

}
