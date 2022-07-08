//
//  SignUpViewController.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 08.07.2022.
//

import UIKit

class SignUpViewController: UIViewController {

    private var person: Person!
    
    @IBOutlet var errorLabel: UILabel!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var repeatPasswordTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var singUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func segmentedControlAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
        case 0:
            person.role = "Mentor"
        case 1:
            person.role = "Mentee"
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
            person.name = nameTextField.text!
            person.email = emailTextField.text!
    
            let vc =  self.storyboard?.instantiateViewController(withIdentifier: "FormViewController") as! FormViewController
            vc.person = person
            vc.navigationController?.pushViewController(vc, animated: true)
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
