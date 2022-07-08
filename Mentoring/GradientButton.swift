//
//  GradientButton.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 08.07.2022.
//

import UIKit

class GradientButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.init(red: 137/255, green: 192/255, blue: 97/255, alpha: 1).cgColor, UIColor.white]
        layer.addSublayer(gradient)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

}
