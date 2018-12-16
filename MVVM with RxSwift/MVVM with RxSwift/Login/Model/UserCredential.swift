//
//  UserCredential.swift
//  MVVM with RxSwift
//
//  Created by Osama Bin Bashir on 16/12/2018.
//  Copyright © 2018 Osama Bin Bashir. All rights reserved.
//

import Foundation

struct UserCredential {
    let userName : String
    let password : String
    
    init(userName : String, password : String) {
        self.userName = userName
        self.password = password
    }
}
