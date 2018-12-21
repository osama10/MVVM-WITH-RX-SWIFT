//
//  LoginService.swift
//  MVVM with RxSwift
//
//  Created by Osama Bin Bashir on 16/12/2018.
//  Copyright © 2018 Osama Bin Bashir. All rights reserved.
//

import Foundation
import RxSwift

enum LoginServiceError: String , Error {
    case invalidUserName = "User name is invalid. please try again."
    case invalidPassword = "password is invalid. please try again"
}

extension LoginServiceError: LocalizedError {
    var errorDescription: String? {
        return self.rawValue
    }
}

class LoginService{
    
    func login(userCred : UserCredential, result : @escaping (Bool)->Void){
        let isValidCred = (userCred.userName == "osama" && userCred.password == "123")
        result(isValidCred)
    }
    
    func login(userCred : UserCredential) -> Completable {
        switch true {
        case userCred.userName != "osama": return .error(LoginServiceError.invalidUserName)
        case userCred.password != "123": return .error(LoginServiceError.invalidPassword)
        default: return .empty()
        }
    }
}
