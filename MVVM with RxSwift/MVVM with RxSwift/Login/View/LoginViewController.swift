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
        usernameTextField.rx.text.orEmpty.bind(to: viewModel.userName).disposed(by: disposeBag)
        passwordTextField.rx.text.orEmpty.bind(to: viewModel.password).disposed(by: disposeBag)
        loginButton.rx.tap.bind(to: viewModel.loginDidTap).disposed(by: disposeBag)
        
        viewModel.canLogin.drive(loginButton.rx.isEnabled).disposed(by: disposeBag)
        viewModel.canLogin.map({ $0 ? 1.0 : 0.5 }).drive(loginButton.rx.alpha).disposed(by: disposeBag)
        viewModel.message.drive(onNext: showAlert).disposed(by: disposeBag)
    }
    
    private func showAlert(message : String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}

