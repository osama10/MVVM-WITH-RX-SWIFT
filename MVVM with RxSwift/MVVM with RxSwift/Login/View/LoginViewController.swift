//
//  ViewController.swift
//  MVVM with RxSwift
//
//  Created by Osama Bin Bashir on 16/12/2018.
//  Copyright © 2018 Osama Bin Bashir. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    @IBOutlet weak var loginButton : UIButton!
    
    let viewModel = LoginViewModel(loginService: LoginService())
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.initialSetting()
    }
    
    private func initialSetting(){
        self.usernameTextField.addTarget(self, action: #selector(usernameTextFieldDidChange(textField:)), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(passworldTextFieldDidChange(textField:)), for: .editingChanged)
        
    }
    
    @objc func usernameTextFieldDidChange(textField: UITextField){
        viewModel.userName = textField.text ?? ""
    }
    
    @objc func passworldTextFieldDidChange(textField: UITextField){
        viewModel.password = textField.text ?? ""
    }
    @IBAction func didTapOnLoginButton(_ sender: UIButton) {
        self.viewModel.didTapOnLogin()
    }
}

