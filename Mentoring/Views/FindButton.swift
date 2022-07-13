//
//  FindButton.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 13.07.2022.
//

import UIKit
import PopBounceButton

class FindButton: PopBounceButton {

    override init() {
      super.init()
      adjustsImageWhenHighlighted = false
      backgroundColor = .white
      layer.masksToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
      return nil
    }

    override func draw(_ rect: CGRect) {
      super.draw(rect)
      layer.cornerRadius = frame.width / 2
    }

}
