//
//  LoginViewModel.swift
//  MVVM with RxSwift
//
//  Created by Osama Bin Bashir on 16/12/2018.
//  Copyright © 2018 Osama Bin Bashir. All rights reserved.
//

import Foundation
import RxSwift

class LoginViewModel {
    
    var userName = Variable<String>("")
    var password = Variable<String>("")
    var result = Variable<String>("")
    var loginButtonTapped = PublishSubject<Void>()
    var isValid : Observable<Bool>{
        return  Observable<Bool>.combineLatest(self.userName.asObservable(), self.password.asObservable(), resultSelector: { (_userName, _password) -> Bool in
            return !(_userName.isEmpty || _password.isEmpty)
        })
        
    }
    
    private let loginService : LoginService
    private let disposeBag = DisposeBag()
    
    init(loginService : LoginService) {
        self.loginService = loginService
        self.makeSubscriptions()
    }
    

    private func makeSubscriptions(){
        self.loginButtonTapped.subscribe {  [weak self] _ in
            guard let `self` = self else { return }
            self.attemptLogin(userName: self.userName.value, password: self.password.value)
            
        }.disposed(by: disposeBag)
    }
    
    private func attemptLogin(userName : String, password : String){
        let userCred = UserCredential(userName: userName, password: password)
        self.loginService.login(userCred: userCred) { [weak self] (isValidCred) in
            guard let `self` = self else { return }
            self.result.value = (isValidCred) ? "Login Successful" : "Login Failed"
        }
    }
    
}
