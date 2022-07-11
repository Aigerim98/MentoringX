//
//  FindMentorViewController.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 11.07.2022.
//

import UIKit
import Koloda

class FindMentorViewController: UIViewController {

    @IBOutlet var koloda: KolodaView!
    
    fileprivate var dataSource: [UIImage] = {
        var array: [UIImage] = []
        for index in 0..<5 {
            array.append(UIImage(named: "Card_like_\(index + 1)")!)
        }
        
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        koloda.dataSource = self
        koloda.delegate = self

        self.modalTransitionStyle = UIModalTransitionStyle.flipHorizontal
    }

    @IBAction func leftButtonTapped(_ sender: Any) {
        koloda.swipe(.left)
    }
    
    @IBAction func rightButtonTapped(_ sender: Any) {
        koloda.swipe(.right)
    }
}


extension FindMentorViewController: KolodaViewDelegate, KolodaViewDataSource {
    
    func kolodaDidRunOutOfCards(_ koloda: KolodaView) {
        let position = koloda.currentCardIndex
        for i in 1...4 {
          dataSource.append(UIImage(named: "Card_like_\(i)")!)
        }
        koloda.insertCardAtIndexRange(position..<position + 4, animated: true)
    }
    
    func koloda(_ koloda: KolodaView, didSelectCardAt index: Int) {
        UIApplication.shared.openURL(URL(string: "https://yalantis.com/")!)
    }
    
    func kolodaNumberOfCards(_ koloda: KolodaView) -> Int {
        return dataSource.count
    }
    
    func kolodaSpeedThatCardShouldDrag(_ koloda: KolodaView) -> DragSpeed {
        return .default
    }
    
    func koloda(_ koloda: KolodaView, viewForCardAt index: Int) -> UIView {
        return UIImageView(image: dataSource[Int(index)])
    }
    
    func koloda(_ koloda: KolodaView, viewForCardOverlayAt index: Int) -> OverlayView? {
        return Bundle.main.loadNibNamed("OverlayView", owner: self, options: nil)?[0] as? OverlayView
    }
    
}

