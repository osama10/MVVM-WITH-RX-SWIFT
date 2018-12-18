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
        self.viewModelBindings()
    }
   
    private func viewModelBindings(){
        self.bindViews()
        self.bindStates()
    }
    
    private func bindViews(){
        self.usernameTextField.rx.text
            .orEmpty
            .bind(to: self.viewModel.userName)
            .disposed(by: disposeBag)
        
        self.passwordTextField.rx.text
            .orEmpty
            .bind(to: self.viewModel.password)
            .disposed(by: disposeBag)
        
        self.loginButton.rx.tap
            .bind(to : self.viewModel.loginButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func bindStates(){
       
        self.viewModel.isValid
            .subscribe(onNext: { [weak self] (isValid) in
                guard let `self` = self else { return }
                self.updateLoginButton(isValid: isValid)
            }).disposed(by: disposeBag)
        
        self.viewModel.result.asObservable()
            .subscribe (onNext : { [weak self]  (message) in
                guard let `self` = self else { return }
                self.showAlert(message: message)
            }).disposed(by: disposeBag)
    }
   
    private func updateLoginButton(isValid : Bool){
        self.loginButton.backgroundColor =  (isValid) ? .black : .gray
        self.loginButton.isEnabled = isValid
    }
    
    private func showAlert(message : String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

}

