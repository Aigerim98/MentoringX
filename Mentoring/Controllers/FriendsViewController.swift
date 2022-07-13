//
//  FriendsViewController.swift
//  Mentoring
//
//  Created by Айгерим Абдурахманова on 10.07.2022.
//

import UIKit

class FriendsViewController: UIViewController {

    var token: String!
    
    var requests: [MenteeCards] = [] {
        didSet{
            tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    private var networkManager: NetworkManager = .shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getRequests()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func acceptTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func declineTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func reportButton(_ sender: UIButton) {
        
    }
    
    func getRequests(){
        networkManager.getMenteeId(token: token) { [weak self] ids in
            print(ids)
            guard let self = self else { return }
            for id in ids.ids {
                self.networkManager.getMentorsById(id: id, token: self.token, completion: { mentee in
                    self.requests.append(MenteeCards(fullName: mentee.fullName, subjectList: mentee.subjectList))
                })
            }
        }
    }
    
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.layer.cornerRadius = 3
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
//        cell.textLabel?.text = "Aigerim"
//        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        vc.title = "Chat"
        vc.isNewConversation = true
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
