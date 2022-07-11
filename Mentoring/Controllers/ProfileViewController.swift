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
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewFlowLayout {
    
    
    
}
