//
//  AddNewsViewController.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 12.07.2022.
//

import UIKit

protocol AddNewDelegate: AnyObject {
    func addNews(news: News)
}

class AddNewsViewController: UIViewController {

    weak var delegate: AddNewDelegate?
    
    var person: Person!
    @IBOutlet var fullNameLabel: UILabel!
    
    @IBOutlet var universityLabel: UILabel!
    @IBOutlet var schoolLabel: UILabel!
    
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fullNameLabel.text = person.fullName
        schoolLabel.text = person.school
        universityLabel.text = "BSc Kazakh - British Technical University, MSc University of Glasgow"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
    }
    
    @objc private func doneTapped() {
        let news = News(news: textView.text)
        delegate?.addNews(news: news)
        navigationController?.popViewController(animated: true)
    }

}
