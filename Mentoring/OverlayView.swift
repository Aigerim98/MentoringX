//
//  OverlayView.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 11.07.2022.
//

import Foundation
import Koloda

private let overlayRightImageName = "yesOverlayImage"
private let overlayLeftImageName = "noOverlayImage"

class ExampleOverlayView: OverlayView {
    

    @IBOutlet lazy var overlayImageView: UIImageView! = {
        [unowned self] in

        var imageView = UIImageView(frame: self.bounds)
        self.addSubview(imageView)

        return imageView
    }()
    
    override var overlayState: SwipeResultDirection? {
        didSet {
            switch overlayState {
            case .left? :
                overlayImageView.image = UIImage(named: overlayLeftImageName)
            case .right? :
                overlayImageView.image = UIImage(named: overlayRightImageName)
            default:
                overlayImageView.image = nil
            }
        }
    }

}
