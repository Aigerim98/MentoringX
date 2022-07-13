//
//  FormViewController.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 08.07.2022.
//

import UIKit
import SwiftCheckboxDialog

protocol UserInfoDelegate: AnyObject {
    func getUserInfo()
}

class FormViewController: UIViewController {

    var token: String!
    
    weak var delegate: UserInfoDelegate?
    
    private var checkboxDialogViewController: CheckboxDialogViewController!
    private let networkManager: NetworkManager = .shared
    private var majors: Majors!
    private var school: String!
    
    typealias TranslationTuple = (name: String, translated: String)
    typealias TranslationDictionary = [String : String]
    
    @IBOutlet weak var universityTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var iinTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    
    @IBOutlet weak var majorButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet var schoolPicker: UIPickerView!
    @IBOutlet weak var createAccountButton: UIButton!
    
    
    private var schools: [String] = ["Международная школа г. Нур-Султан",
                                     "Школа физико-математического направления г.Нур-Султан",
                                     "Интеллектуальная школа г. Нур-Султан",
                                     "Школа физико-математического направления г.Кокшетау",
                                     "Школа физико-математического направления г. Талдыкорган",
                                     "Школа физико-математического направления г.Семей",
                                     "Школа физико-математического направления г. Уральск",
                                     "Школа химико-биологического направления г. Усть-Каменогорск",
                                     "Школа физико-математического направления г.Актобе",
                                     "Школа химико-биологического направления г.Караганда",
                                     "Школа химико-биологического направления г.Шымкент",
                                     "Школа физико-математического направления г.Шымкент",
                                     "Школа физико-математического направления г.Тараз",
                                     "Школа химико-биологического направления г.Кызылорда",
                                     "Школа химико-биологического направления г.Павлодар",
                                     "Школа химико-биологического направления г.Атырау",
                                     "Школа физико-математического направления в г. Алматы",
                                     "Школа физико-математического направления г.Костанай",
                                     "Школа химико-биологического направления г.Петропавловск",
                                     "Школа химико-биологического направления г.Алматы",
                                     "Школа химико-биологического направления г. Актау",
                                     "Школа химико-биологического направления г.Туркестан"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        schoolPicker.delegate = self
        schoolPicker.dataSource = self
    }
    
    @IBAction func majorButtonTapped(_ sender: UIButton) {
        let tableData :[(name: String, translated: String)] = [("0", "Math"),
                                                                        ("1", "Physics"),
                                                                        ("2", "Chemistry"),
                                                                        ("3", "Biology"),
                                                                        ("4", "Informatics"),
                                                                        ("5", "History")]

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
        guard let city = cityTextField.text, cityTextField.hasText else { return }
        guard let iin = iinTextField.text, iinTextField.hasText else { return }
        guard let phoneNumber = phoneTextField.text, phoneTextField.hasText else { return }
        guard let university = universityTextField.text, universityTextField.hasText else { return }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let dateOfBirth = dateFormatter.string(from: datePicker.date)

        let credentials = UserInfo(city: city, school: school, phoneNumber: phoneNumber, university: university, dateOfBirth: dateOfBirth, iin: iin)

        networkManager.postUserInfo(token: token!, credentials: credentials) { [weak self] result in
            guard let self = self else { return }
                switch result {
                case let .success(message):
                    print(message)
                case let .failure(error):
                    print(error)
                }
        }

        networkManager.postMajors(token: token!, credentials: majors) { [weak self] result in
            guard let self = self else { return }
                switch result {
                case let .success(message):
                    print(message)
                case let .failure(error):
                    print(error)
                }
        }
        
//        let sceneDelegate = UIApplication.shared.delegate as! SceneDelegate
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
//        sceneDelegate.window?.rootViewController = vc
//        sceneDelegate.window?.makeKeyAndVisible()
        delegate?.getUserInfo()
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setUpUI() {
        Utilities.styleTextField(cityTextField)
        Utilities.styleTextField(phoneTextField)
        Utilities.styleTextField(universityTextField)
        Utilities.styleTextField(iinTextField)
        Utilities.styleHollowButton(majorButton)
        Utilities.styleFilledButton(createAccountButton)
        
//        if person.role == "Mentee" {
//            universityTextField.isUserInteractionEnabled = false
//        }
    }
}

extension FormViewController: CheckboxDialogViewDelegate {
    
    func onCheckboxPickerValueChange(_ component: DialogCheckboxViewEnum, values: TranslationDictionary) {
        print(values.keys)
        majors = Majors(majors: [])
        for (key, value) in values {
            //majors.append(Int(key)!)
            print(key)
           majors.majors.append(Int(key)!)
        }
    }
    
}

extension FormViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        schools.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        schools[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        school = schools[row]
    }
    
}
