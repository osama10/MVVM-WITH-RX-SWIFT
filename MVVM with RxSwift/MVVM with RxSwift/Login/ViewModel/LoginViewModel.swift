//
//  LoginViewModel.swift
//  MVVM with RxSwift
//
//  Created by Osama Bin Bashir on 16/12/2018.
//  Copyright © 2018 Osama Bin Bashir. All rights reserved.
//

import Foundation

class LoginViewModel {
    
    var userName = ""{
        didSet{
            self.isValid = self.validateCredentials()
        }
    }
    var password = ""{
        didSet{
           self.isValid = self.validateCredentials()
        }
    }
    
    var isCredentialsValid : ((Bool)->Void)?
    
    private var isValid = false {
        didSet{
            self.isCredentialsValid?(self.isValid)
        }
    }
    
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
    
    private func validateCredentials()->Bool{
        return !(self.userName.isEmpty || self.password.isEmpty)
    }
    
}
