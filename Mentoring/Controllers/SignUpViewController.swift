//
//  SignUpViewController.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 08.07.2022.
//

import UIKit

class SignUpViewController: UIViewController {

   // private var person: Person!
    
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var repeatPasswordTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var singUpButton: UIButton!
    
    private let networkManager: NetworkManager = .shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
           print("Mentor")
        case 1:
            print("Mentee")
        default:
            break
        }
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }else {
            hideError()
    
            let fullName = nameTextField.text!
            let email = emailTextField.text!
            let password = passwordTextField.text!
            
            let credentials = Registration(fullName: fullName, email: email, password: password, role: 1)
            
            networkManager.postRegister(credentials: credentials) { [weak self] result in
                guard let self = self else { return }
                    switch result {
                    case let .success(message):
                        print(message)
                        //self.navigationController?.popToRootViewController(animated: true)
                        let verificationCredentials = ProcessRegistration(email: email)
                        
                        self.networkManager.postRegisterVerification(credentials: verificationCredentials) { [weak self] result in
                            guard let self = self else { return }
                                switch result {
                                case let .success(message):
                                    print(message)
                                    self.navigationController?.popToRootViewController(animated: true)
                                case let .failure(error):
                                    print(error)
                                }
                        }
                    case let .failure(error):
                        print(error)
                    }
            }
            
           
            
//            let vc =  self.storyboard?.instantiateViewController(withIdentifier: "FormViewController") as! FormViewController
//            vc.person = person
//            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func setUpUI() {
        Utilities.styleHollowButton(singUpButton)
        Utilities.styleTextField(nameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleTextField(repeatPasswordTextField)
    }

    private  func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.textColor = .systemRed
        errorLabel.alpha = 1
    }
    
    private func hideError() {
        errorLabel.alpha = 0
    }
    
    private func validateFields() -> String? {
        if !nameTextField.hasText || !emailTextField.hasText || !passwordTextField.hasText || !repeatPasswordTextField.hasText {
            return "Please fill all fields"
        }
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //let repeatedCleanedPassword = repeatPasswordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if !Utilities.isPasswordValid(cleanedPassword) {
            return "PLease make sure your password is at least 8 charactes, contains a special character and number"
        }
        
        if !Utilities.isEmailValid(cleanedEmail) {
            return "Invalid email address"
        }
        
        if passwordTextField.text != repeatPasswordTextField.text {
            return "Passwords do not match"
        }
        
        return nil
    }
}
