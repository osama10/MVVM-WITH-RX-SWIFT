//
//  ViewController.swift
//  MVVM with RxSwift
//
//  Created by Osama Bin Bashir on 16/12/2018.
//  Copyright © 2018 Osama Bin Bashir. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var loginButton : UIButton!
    let viewModel = LoginViewModel(loginService: LoginService())
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelBinding()
    }
    
    func viewModelBinding() {
        //input binding
        [usernameTextField.rx.text.orEmpty.bind(to: viewModel.userName),
         passwordTextField.rx.text.orEmpty.bind(to: viewModel.password),
         loginButton.rx.tap.bind(to: viewModel.loginDidTap),
         //output binding
            viewModel.canLogin.drive(loginButton.rx.isEnabled),
            viewModel.canLogin.map({ $0 ? 1.0 : 0.5 }).drive(loginButton.rx.alpha),
            viewModel.message.drive(onNext: showAlert)]
            .forEach({ $0.disposed(by: disposeBag)})
    }
    
    private func showAlert(message : String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

