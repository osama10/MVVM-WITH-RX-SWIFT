//
//  LoginViewModel.swift
//  MVVM with RxSwift
//
//  Created by Osama Bin Bashir on 16/12/2018.
//  Copyright © 2018 Osama Bin Bashir. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    var userName = BehaviorSubject<String>(value: "")
    var password = BehaviorSubject<String>(value: "")
    var loginDidTap = PublishSubject<Void>()
    
    let message: Driver<String>
    let canLogin: Driver<Bool>
    
    init(loginService : LoginService) {
        
        let input = Observable.combineLatest(userName,password)
        
        let isValid = input.map({ $0.isEmpty == false && $1.isEmpty == false })
        
        canLogin = isValid.asDriver(onErrorJustReturn: false)
        
        message = loginDidTap
            .withLatestFrom(input)
            .map({UserCredential(userName: $0, password: $1)})
            .flatMap { (user: UserCredential) -> Observable<String> in
                return loginService.login(userCred: user)
                    .andThen(.just("LogedIn Successfully"))
                    .catchError({ return .just($0.localizedDescription) })
            }.asDriver(onErrorJustReturn: "")
    }
}
