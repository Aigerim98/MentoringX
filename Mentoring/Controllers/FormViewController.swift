//
//  FormViewController.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 08.07.2022.
//

import UIKit
import SwiftCheckboxDialog

class FormViewController: UIViewController {

    var person: Person
    
    private var checkboxDialogViewController: CheckboxDialogViewController!
    
    typealias TranslationTuple = (name: String, translated: String)
    typealias TranslationDictionary = [String : String]
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    
}

extension FormViewController: CheckboxDialogViewDelegate {
    
    func onCheckboxPickerValueChange(_ component: DialogCheckboxViewEnum, values: TranslationDictionary) {
        print(component)
        print(values)
    }
    
}
