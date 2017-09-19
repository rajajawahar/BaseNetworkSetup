//
//  BasePresenter.swift
//  BaseNetworkSetup
//
//  Created by rajamohamed on 14/09/17.
//  Copyright © 2017 Raja Mohamed. All rights reserved.
//

import Foundation

protocol BasePresenter  {
    
    associatedtype View
    
    func attachView(view : View)
    
    func detachView()
    
    func destroy()
    
}
