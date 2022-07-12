//
//  NewsViewController.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 12.07.2022.
//

import UIKit

class NewsViewController: UIViewController {

    var person: Person!
    var education: [Education] = []
    
    private var persons: [Person] = [Person(fullName: "Ant Man", email: "adam@gmail.com", role: "mentor", school: "NIS Astana", graduationYear: "2015", phoneNumber: "123456789", university: "MIT"),
        Person(fullName: "Ant Man", email: "adam@gmail.com", role: "mentor", school: "NIS Astana", graduationYear: "2015", phoneNumber: "123456789", university: "MIT"),
                                     Person(fullName: "Ant Man", email: "adam@gmail.com", role: "mentor", school: "NIS Astana", graduationYear: "2015", phoneNumber: "123456789", university: "MIT")]
                                                                                                                                                                                                    
    private var news: [String] = ["sdgfhjkll;lfdrtfyguhijokpiuytrdtfyguhijokplijuhgytfrdfyguhijokpijuhygtfrdughiojkpiuygthijo", "sdgfhjkll;lfdrtfyguhijokpiuytrdtfyguhijokplijuhgytfrdfyguhijokpijuhygtfrdughiojkpiuygthijosdgfhjkll;lfdrtfyguhijokpiuytrdtfyguhijokplijuhgytfrdfyguhijokpijuhygtfrdughiojkpiuygthijo", "sdgfhjkll;lfdrtfyguhijokpiuytrdtfyguhijokplijuhgytfrdfyguhijokpijuhygtfrdughiojkpiuygthijosdgfhjkll;lfdrtfyguhijokpiuytrdtfyguhijokplijuhgytfrdfyguhijokpijuhygtfrdughiojkpiuygthijosdgfhjkll;lfdrtfyguhijokpiuytrdtfyguhijokplijuhgytfrdfyguhijokpijuhygtfrdughiojkpiuygthijosdgfhjkll;lfdrtfyguhijokpiuytrdtfyguhijokplijuhgytfrdfyguhijokpijuhygtfrdughiojkpiuygthijo" ]
    
    @IBOutlet private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
    }
    
    
    @IBAction func addNews(_ sender: UIBarButtonItem) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddNewsViewController") as! AddNewsViewController
        self.navigationController?.pushViewController(vc, animated: true)
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
        cell.configure(with: persons[indexPath.section], news: news[indexPath.section])
       
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.clipsToBounds = true
        return cell
    }
}
