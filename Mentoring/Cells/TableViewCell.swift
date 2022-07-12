//
//  TableViewCell.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 12.07.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    @IBOutlet var universityImage: UIImageView!
    @IBOutlet var yearOfStudyLabel: UILabel!
    @IBOutlet var majorLabel: UILabel!
    @IBOutlet var universityLabel: UILabel!
    
    func configure(with education: Education) {
        //let image = UIImage(named: education.image)
        universityImage = UIImageView(image: UIImage(named: education.image))
        yearOfStudyLabel.text = education.yearsOfStudy
        majorLabel.text = education.major
        universityLabel.text = education.university
    }
}
