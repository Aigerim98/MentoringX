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

class FindMentorViewController: UIViewController {
    
    private let cardStack = SwipeCardStack()
    private let buttonStackView = ButtonStackView()
    private var networkManager: NetworkManager = .shared
    
    var token: String!
    var mentorIds: [Int] = []
    
    var mentors: [TinderCardModel] = [TinderCardModel(name: "Mentor 1", university: "NU", occupation: "Math", image: UIImage(named: "mentor_1")),
        TinderCardModel(name: "Mentor 2", university: "MIT", occupation: "Informatics", image: UIImage(named: "mentor_2")),
                                      TinderCardModel(name: "Mentor 3", university: "NU", occupation: "Math", image: UIImage(named: "mentor_3"))] {
        didSet{
            cardStack.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMentorIDs()
        
        cardStack.delegate = self
        cardStack.dataSource = self
        buttonStackView.delegate = self
        
        configureNavigationBar()
        layoutButtonStackView()
        layoutCardStackView()
        configureBackgroundGradient()
        
        print(self.mentorIds)
    }
    
    func getMentorIDs() {
        networkManager.getMentorId(token: token) { [weak self] ids in
            guard let self = self else { return }
                for id in ids.ids {
                    self.networkManager.getMentorsById(id: id, token: self.token) { [weak self] mentorCard in
                        self!.mentors.append(TinderCardModel(name: mentorCard.fullName, university: mentorCard.university, occupation: String(mentorCard.subjectList[0]), image: UIImage(named: "mentor_1")))
                    }
                }
                
        }
        
    }
    
    private func configureNavigationBar() {
      let backButton = UIBarButtonItem(title: "Back",
                                       style: .plain,
                                       target: self,
                                       action: #selector(handleShift))
      backButton.tag = 1
      backButton.tintColor = .lightGray
      navigationItem.leftBarButtonItem = backButton

      let forwardButton = UIBarButtonItem(title: "Forward",
                                          style: .plain,
                                          target: self,
                                          action: #selector(handleShift))
      forwardButton.tag = 2
      forwardButton.tintColor = .lightGray
      navigationItem.rightBarButtonItem = forwardButton

      navigationController?.navigationBar.layer.zPosition = -1
    }

    private func configureBackgroundGradient() {
      let backgroundGray = UIColor(red: 244 / 255, green: 247 / 255, blue: 250 / 255, alpha: 1)
      let gradientLayer = CAGradientLayer()
      gradientLayer.colors = [UIColor.white.cgColor, backgroundGray.cgColor]
      gradientLayer.frame = view.bounds
      view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func layoutButtonStackView() {
      view.addSubview(buttonStackView)
      buttonStackView.anchor(left: view.safeAreaLayoutGuide.leftAnchor,
                             bottom: view.safeAreaLayoutGuide.bottomAnchor,
                             right: view.safeAreaLayoutGuide.rightAnchor,
                             paddingLeft: 24,
                             paddingBottom: 12,
                             paddingRight: 24)
    }

    private func layoutCardStackView() {
      view.addSubview(cardStack)
      cardStack.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                       left: view.safeAreaLayoutGuide.leftAnchor,
                       bottom: buttonStackView.topAnchor,
                       right: view.safeAreaLayoutGuide.rightAnchor)
    }

    @objc private func handleShift(_ sender: UIButton) {
      cardStack.shift(withDistance: sender.tag == 1 ? -1 : 1, animated: true)
    }
}

extension FindMentorViewController: ButtonStackViewDelegate, SwipeCardStackDataSource, SwipeCardStackDelegate {

  func cardStack(_ cardStack: SwipeCardStack, cardForIndexAt index: Int) -> SwipeCard {
    let card = SwipeCard()
    card.footerHeight = 80
    card.swipeDirections = [.left, .up, .right]
    for direction in card.swipeDirections {
      card.setOverlay(TinderCardOverlay(direction: direction), forDirection: direction)
    }

      let model = mentors[index]
      card.content = TinderCardContentView(withImage: model.image)
    card.footer = TinderCardFooterView(withTitle: "\(model.name), \(model.university)", subtitle: model.occupation)

    return card
  }

  func numberOfCards(in cardStack: SwipeCardStack) -> Int {
      return mentors.count
  }

  func didSwipeAllCards(_ cardStack: SwipeCardStack) {
    print("Swiped all cards!")
  }

  func cardStack(_ cardStack: SwipeCardStack, didUndoCardAt index: Int, from direction: SwipeDirection) {
    print("Undo \(direction) swipe on \(mentors[index].name)")
  }

  func cardStack(_ cardStack: SwipeCardStack, didSwipeCardAt index: Int, with direction: SwipeDirection) {
    print("Swiped \(direction) on \(mentors[index].name)")
  }

  func cardStack(_ cardStack: SwipeCardStack, didSelectCardAt index: Int) {
    print("Card tapped")
  }

  func didTapButton(button: FindButton) {
    switch button.tag {
    case 1:
      cardStack.undoLastSwipe(animated: true)
    case 2:
      cardStack.swipe(.left, animated: true)
    case 3:
      cardStack.swipe(.up, animated: true)
    case 4:
      cardStack.swipe(.right, animated: true)
    case 5:
      cardStack.reloadData()
    default:
      break
    }
  }
}
