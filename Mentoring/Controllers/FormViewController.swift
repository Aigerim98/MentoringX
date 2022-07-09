//
//  FormViewController.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 08.07.2022.
//

import UIKit
import SwiftCheckboxDialog

class FormViewController: UIViewController {

    var person: Person!
    
    private var checkboxDialogViewController: CheckboxDialogViewController!
    
    typealias TranslationTuple = (name: String, translated: String)
    typealias TranslationDictionary = [String : String]
    
    @IBOutlet weak var universityTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var iinTextField: UITextField!
    @IBOutlet weak var schoolTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var majorButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var createAccountButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
    }
    
    @IBAction func majorButtonTapped(_ sender: UIButton) {
        let tableData :[(name: String, translated: String)] = [("Math", "Math"),
                                                                        ("Physics", "Physics"),
                                                                        ("Chemistry", "Chemistry"),
                                                                        ("Biology", "Biology"),
                                                                        ("Informatics", "Informatics"),
                                                                        ("History", "History")]

        self.checkboxDialogViewController = CheckboxDialogViewController()
        self.checkboxDialogViewController.titleDialog = "Courses"
        self.checkboxDialogViewController.tableData = tableData
        self.checkboxDialogViewController.defaultValues = [tableData[3]]
        self.checkboxDialogViewController.componentName = DialogCheckboxViewEnum.countries
        self.checkboxDialogViewController.delegateDialogTableView = self
        self.checkboxDialogViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(self.checkboxDialogViewController, animated: false, completion: nil)
    }
    
    @IBAction func createAcoountButtonTapped(_ sender: UIButton) {
    }
    private func setUpUI() {
        Utilities.styleTextField(cityTextField)
        Utilities.styleTextField(phoneTextField)
        Utilities.styleTextField(iinTextField)
        Utilities.styleTextField(schoolTextField)
        Utilities.styleTextField(universityTextField)
        Utilities.styleHollowButton(majorButton)
        Utilities.styleFilledButton(createAccountButton)
        
        if person.role == "Mentee" {
            universityTextField.isUserInteractionEnabled = false
        }
    }
}

extension FormViewController: CheckboxDialogViewDelegate {
    
    func onCheckboxPickerValueChange(_ component: DialogCheckboxViewEnum, values: TranslationDictionary) {
        print(component)
        print(values)
    }
    
}
