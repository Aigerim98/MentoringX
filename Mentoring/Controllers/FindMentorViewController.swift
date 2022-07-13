//
//  FindMentorViewController.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 11.07.2022.
//

import UIKit
import Koloda
import Shuffle_iOS
import PopBounceButton

class FindMentorViewController: UIViewController, CardViewDelegate {
   
    func didRemoveCard(cardView: CardView) {
        print("remove")
    }
    
    
    //let topStackView = TopNavigationStackView()
    let cardsDeckView = UIView()
    let bottomControls = HomeBottomControlStackView()
    var topCardView: CardView?
    
    var persons: [Mentor: String] = [Mentor(fullName: "Mentor 1", email: "mentor1@gmail.com", role: "Mentor", phoneNumber: "5678", university: "MIT", image: "mentor_1"): "Math", Mentor(fullName: "Mentor 2", email: "mentor2@gmail.com", role: "Mentor", phoneNumber: "68790", university: "NU", image: "mentor_2") : "Biology", Mentor(fullName: "Mentor 3", email: "mentor3@gmail.com", role: "mentor", phoneNumber: "5678", university: "NU", image: "mentor_3") : "Informatics"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomControls.dislikeButton.addTarget(self, action: #selector(dislikeButtonTapped), for: .touchUpInside)
        bottomControls.undoButton.addTarget(self, action: #selector(undoButtonTapped), for: .touchUpInside)
        bottomControls.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        setupDummyCards()
        setupLayout()
    }
    
    @objc private func dislikeButtonTapped() {
        print("dislike pressed")
    }
    
    @objc private func likeButtonTapped() {
        print("like pressed")
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            
            self.topCardView?.frame = CGRect(x: 600, y: 0, width: self.topCardView!.frame.width, height: self.topCardView!.frame.height)
            let angle = 15 * CGFloat.pi / 180
            self.topCardView?.transform = CGAffineTransform(rotationAngle: angle)
            
        })
    }
    
    @objc private func undoButtonTapped() {
        print("undo")
    }
    fileprivate func setupDummyCards() {
        persons.forEach { (person) in
            
            let cardView = CardView(frame: .zero)
            cardView.imageView.image = UIImage(named: person.key.image)
            cardView.informationLabel.text = "\(person.key.fullName) \(person.key.university)\n\(person.value)"
            
            let attributedText = NSMutableAttributedString(string: person.key.fullName, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
            attributedText.append(NSAttributedString(string: "  \(person.key.university)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
            
            attributedText.append(NSAttributedString(string: "\n\(person.value)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
            
            cardView.informationLabel.attributedText = attributedText
            
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
    }
    
//    fileprivate func fetchMentors() {
//        var previousCardView: CardView?
//
//        if self.topCardView == nil {
//            self.topCardView = cardView
//        }
//    }
    
//    fileprivate func setupCardFromUser(person: Person) -> CardView {
//        let cardView = CardView(frame: .zero)
//        cardView.delegate = self
//       // cardView.cardViewModel = person.toCardViewModel()
//        let cardView = setupCardFromUser(person: person)
//        cardsDeckView.addSubview(cardView)
//        cardsDeckView.sendSubviewToBack(cardView)
//        cardView.fillSuperview()
//        return cardView
//    }
    
    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [cardsDeckView, bottomControls])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        
        overallStackView.bringSubviewToFront(cardsDeckView)
    }
}
