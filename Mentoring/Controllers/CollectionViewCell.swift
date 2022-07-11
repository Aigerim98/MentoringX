//
//  CollectionViewCell.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 11.07.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var label: UILabel!
    
    func configure(with major: String) {
        label.text = major
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 2.5
    }
}
