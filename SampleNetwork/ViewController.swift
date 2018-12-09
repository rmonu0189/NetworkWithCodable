//
//  ViewController.swift
//  SampleNetwork
//
//  Created by Monu on 09/12/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginButtonTapped(_ sender: Any) {
        let service = APIService.login(mobile: mobileTextField.text ?? "", password: passwordTextField.text ?? "")
        DataManager.fetch(service, type: User.self) { (user, error) in
            if let connectionError = error {
                print("Error: ", connectionError)
            } else {
                print("User successfully logged in.", user ?? "")
            }
        }
        
        
//        User.loginWithMobile(mobileTextField.text ?? "", password: passwordTextField.text ?? "") { (user, error) in
//            if let connectionError = error {
//                print("Error: ", connectionError)
//            } else {
//                print("User successfully logged in.", user ?? "")
//            }
//        }
    }
    
    private func signUp() {
        let service = APIService.signUp(mobile: mobileTextField.text ?? "", password: passwordTextField.text ?? "")
        DataManager.fetch(service, type: User.self) { (user, error) in
            if let connectionError = error {
                print("Error: ", connectionError)
            } else {
                print("User successfully logged in.", user ?? "")
            }
        }
    }
    
}

