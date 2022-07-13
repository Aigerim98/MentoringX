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
    
    private let networkManager: NetworkManager = .shared
    var data: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
        
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, emailTextField.hasText else { return }
        
        guard let password = passwordTextField.text, passwordTextField.hasText else { return }
        
        let credentials = Login(email: email, password: password)
        
        networkManager.postLogin(credentials: credentials) { [weak self] result in
            guard let self = self else { return }
                switch result {
                case let .success(message):
                    print(message)
                    let vc =  self.storyboard?.instantiateViewController(withIdentifier: "FormViewController") as! FormViewController
                    vc.token = message!
                    self.navigationController?.pushViewController(vc, animated: true)
//                    let vc = (self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController")) as! MainTabBarController
//                    (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc)
                case let .failure(error):
                    print(error)
                }
        }
    }
    
    private func setUpUI() {
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }
    
}
