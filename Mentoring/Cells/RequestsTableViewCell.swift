//
//  RequestsTableViewCell.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 14.07.2022.
//

import UIKit

class RequestsTableViewCell: UITableViewCell {

    @IBOutlet var profielImage: UIImageView!
    @IBOutlet var fullNameLabel: UILabel!
    
    @IBOutlet var majorsLabel: UILabel!
    @IBOutlet var schoolLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
