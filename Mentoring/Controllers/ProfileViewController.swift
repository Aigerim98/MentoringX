//
//  ProfileViewController.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 11.07.2022.
//

import UIKit
import HCSStarRatingView

class ProfileViewController: UIViewController {

    var person: Person!
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var schoolTextLabel: UILabel!
    @IBOutlet var universityTextLabel: UILabel!
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var starRating: HCSStarRatingView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var backgroundView: UIView!
    
    private var majors: [String] = ["Math", "Informatics", "Physics"]
    
    var educations: [Education] = []
    var token: String!
    
    private var networkManager: NetworkManager = .shared
    
    override func viewDidLoad() {
        
        starRating.value = 4.5
        
        fullNameLabel.text = "Aigerim Abdurakhmanova"
        schoolTextLabel.text = "NIS Almaty"
        universityTextLabel.text = "BSc Kazakh - British Technical University, MSc University of Glasgow"
          
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = 90
        
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        gradientView()
        
        print("Profile view controller token \(token)")
    }
    
    func loadData() {
        networkManager.getUserInfo(token: token) { [weak self] person in
            self?.person = person
        }
    }
    
    func gradientView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.backgroundView.bounds
        //gradientLayer.colors = [UIColor.systemGreen.cgColor, UIColor.white.cgColor]
        //gradientLayer.colors = [UIColor(hex: "#AAF1DA"), UIColor(hex: "#F9EA8F")]
        gradientLayer.colors = [UIColor(red: 117/255, green: 239/255, blue: 164/255, alpha: 1).cgColor, UIColor.white.cgColor]
        self.backgroundView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @IBAction func logOutTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
           let vc = storyboard.instantiateViewController(identifier: "ViewController") as! ViewController

           (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(vc)
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        majors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! CollectionViewCell
        cell.configure(with: majors[indexPath.row])
        cell.layer.borderColor = UIColor(red: 117/255, green: 239/255, blue: 164/255, alpha: 1).cgColor
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 5
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
