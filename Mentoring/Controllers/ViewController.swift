//
//  ViewController.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 08.07.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var signInButton: UIButton!
    @IBOutlet var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        
//        let gradient = CAGradientLayer()
//        gradient.frame = signInButton.bounds
//        gradient.colors = [UIColor.init(red: 135/255, green: 192/255, blue: 97/255, alpha: 1).cgColor, UIColor.white]
//        signInButton.layer.insertSublayer(gradient, at: 0)
//        signInButton.layer.cornerRadius = 25
//        signInButton.layer.masksToBounds = true
        setUpButtons()
    }
    
    @IBAction func createAccountTapped(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as! SignUpViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
    }
    
    private func setUpButtons() {
        Utilities.styleFilledButton(signInButton)
        Utilities.styleHollowButton(createAccountButton)
    }
}
