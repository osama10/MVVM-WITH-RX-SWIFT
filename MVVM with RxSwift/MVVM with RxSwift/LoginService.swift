//
//  LoginService.swift
//  MVVM with RxSwift
//
//  Created by Osama Bin Bashir on 16/12/2018.
//  Copyright © 2018 Osama Bin Bashir. All rights reserved.
//

import Foundation

class LoginService{
    
    func login(userCred : UserCredential, result : @escaping (Bool)->Void){
        let isValidCred = (userCred.userName == "osama" && userCred.password == "123")
        result(isValidCred)
    }
}
