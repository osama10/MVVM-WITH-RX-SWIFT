//
//  LoginViewModel.swift
//  MVVM with RxSwift
//
//  Created by Osama Bin Bashir on 16/12/2018.
//  Copyright © 2018 Osama Bin Bashir. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    var userName = ""
    var password = ""
    
    private let loginService : LoginService
    
    init(loginService : LoginService) {
        self.loginService = loginService
    }
    
    func didTapOnLogin(){
        self.attemptLogin(userName: self.userName, password: self.password)
    }
    
    private func attemptLogin(userName : String, password : String){
        let userCred = UserCredential(userName: userName, password: password)
        self.loginService.login(userCred: userCred) { (isValidCred) in
            
        }
    }
    
}
