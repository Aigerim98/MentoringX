//
//  LoginViewController.swift
//  Mentoring
//
//  Created by Айгерим Абдурахманова on 09.07.2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
        
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
    }
    
    private func setUpUI() {
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }
    
}
