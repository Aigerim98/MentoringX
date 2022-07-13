//
//  NewsViewController.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 12.07.2022.
//

import UIKit

class NewsViewController: UIViewController {

    //var person: Person!
    var person: Person = Person(fullName: "Aigerim Abdurakhmanova", email: "aigerim@gmail.com", role: "Mentor", school: "NIS Almaty", phoneNumber: "234567890")
    
    var education: [Education] = []
    
    private var persons: [Person] = [Person(fullName: "Ant Man", email: "adam@gmail.com", role: "mentor", school: "NIS Astana", graduationYear: "2015", phoneNumber: "123456789", university: "MIT"),
        Person(fullName: "Ant Man", email: "adam@gmail.com", role: "mentor", school: "NIS Astana", graduationYear: "2015", phoneNumber: "123456789", university: "MIT"),
                                     Person(fullName: "Ant Man", email: "adam@gmail.com", role: "mentor", school: "NIS Astana", graduationYear: "2015", phoneNumber: "123456789", university: "MIT")]
                                                                                                                                                                                                    
    private var new: [News] = [News(news: "sdgfhjkll;lfdrtfyguhijokpiuytrdtfyguhijokplijuhgytfrdfyguhijokpijuhygtfrdughiojkpiuygthijo"), News(news:"sdgfhjkll;lfdrtfyguhijokpiuytrdtfyguhijokplijuhgytfrdfyguhijokpijuhygtfrdughiojkpiuygthijosdgfhjkll;lfdrtfyguhijokpiuytrdtfyguhijokplijuhgytfrdfyguhijokpijuhygtfrdughiojkpiuygthijo"),
        News(news: "sdgfhjkll;lfdrtfyguhijokpiuytrdtfyguhijokplijuhgytfrdfyguhijokpijuhygtfrdughiojkpiuygthijosdgfhjkll;lfdrtfyguhijokpiuytrdtfyguhijokplijuhgytfrdfyguhijokpijuhygtfrdughiojkpiuygthijosdgfhjkll;lfdrtfyguhijokpiuytrdtfyguhijokplijuhgytfrdfyguhijokpijuhygtfrdughiojkpiuygthijosdgfhjkll;lfdrtfyguhijokpiuytrdtfyguhijokplijuhgytfrdfyguhijokpijuhygtfrdughiojkpiuygthijo" )]
    
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(person)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
    }
    
    
    @IBAction func addNews(_ sender: UIBarButtonItem) {
        print("add")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewsViewController") as! AddNewsViewController
        vc.person = person
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension NewsViewController: AddNewDelegate {
    func addNews(news: News) {
        new.append(news)
        persons.append(Person(fullName: person.fullName, email: person.email, role: person.role,school: person.school, phoneNumber: person.phoneNumber, university: "BSc Kazakh - British Technical University, MSc University of Glasgow"))
        tableView.reloadData()
        print(news)
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        persons.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0.5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsTableCell", for: indexPath) as! NewsTableViewCell
//        cell.configure(with: persons[indexPath.section], news: new[indexPath.section].news)
        cell.configure(with: persons[indexPath.section], news: new[indexPath.section])
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.clipsToBounds = true
        return cell
    }
}
