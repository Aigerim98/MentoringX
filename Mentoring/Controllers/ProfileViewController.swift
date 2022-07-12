//
//  ProfileViewController.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 11.07.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var schoolTextLabel: UILabel!
    @IBOutlet var universityTextLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var backgroundView: UIView!
    
    private var majors: [String] = ["Math", "Informatics", "Physics"]
    
    private var educations: [Education] = [Education(image: "uog.jpg", university: "University of Glasgow", major: "MSc Computer Systems Engineering", yearsOfStudy: "2021 - 2022"), Education(image: "kbtu.jpg", university: "KBTU", major: "BSc Automation and Control", yearsOfStudy: "2015 - 2019")]
    var screenSize: CGRect!
    var screenWidth: CGFloat!
    var screenHeight: CGFloat!
    
    override func viewDidLoad() {
        
        screenSize = view.bounds
        
        screenWidth = screenSize.width
        screenHeight = screenSize.height
        
        fullNameLabel.text = "Aigerim Abdurakhmanova"
        schoolTextLabel.text = "NIS Almaty"
        universityTextLabel.text = "BSc Kazakh - British Technical University, MSc University of Glasgow"
          
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        
        backgroundView.layer.masksToBounds = true
        backgroundView.layer.cornerRadius = backgroundView.frame.height / 2
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        majors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        cell.configure(with: majors[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size:CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
}


extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! TableViewCell
        cell.configure(with: educations[indexPath.row])
        return cell
    }
    
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        educations.count
    }
}
