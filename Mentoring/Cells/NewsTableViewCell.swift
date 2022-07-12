//
//  NewsTableViewCell.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 12.07.2022.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var universityLabel: UILabel!
    @IBOutlet var schoolLabel: UILabel!
    @IBOutlet var fullNameLabel: UILabel!
    
    @IBOutlet var newsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with person: Person, news: String){
        profileImage.layer.cornerRadius = 40
        guard let university = person.university else { return }
        
        universityLabel.text = university
        schoolLabel.text = person.school
        fullNameLabel.text = person.fullName
        newsLabel.text = news
    }

}
