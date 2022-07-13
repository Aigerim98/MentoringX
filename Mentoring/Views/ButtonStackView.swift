//
//  ButtonStackView.swift
//  Mentoring
//
//  Created by Aigerim Abdurakhmanova on 13.07.2022.
//

import UIKit
import PopBounceButton

protocol ButtonStackViewDelegate: AnyObject {
  func didTapButton(button: FindButton)
}

class ButtonStackView: UIStackView {

    weak var delegate: ButtonStackViewDelegate?

    private let undoButton: FindButton = {
      let button = FindButton()
      button.setImage(UIImage(named: "refresh_circle"), for: .normal)
      button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
      button.tag = 1
      return button
    }()

    private let passButton: FindButton = {
      let button = FindButton()
      button.setImage(UIImage(named: "dismiss_circle"), for: .normal)
      button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
      button.tag = 2
      return button
    }()

    private let likeButton: FindButton = {
      let button = FindButton()
      button.setImage(UIImage(named: "tick_2"), for: .normal)
      button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
      button.tag = 4
      return button
    }()


    override init(frame: CGRect) {
      super.init(frame: frame)
      distribution = .equalSpacing
      alignment = .center
      configureButtons()
    }

    required init(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }

    private func configureButtons() {
      let largeMultiplier: CGFloat = 66 / 414 //based on width of iPhone 8+
      let smallMultiplier: CGFloat = 54 / 414 //based on width of iPhone 8+
      addArrangedSubview(from: undoButton, diameterMultiplier: smallMultiplier)
      addArrangedSubview(from: passButton, diameterMultiplier: largeMultiplier)
     // addArrangedSubview(from: superLikeButton, diameterMultiplier: smallMultiplier)
      addArrangedSubview(from: likeButton, diameterMultiplier: largeMultiplier)
      //addArrangedSubview(from: boostButton, diameterMultiplier: smallMultiplier)
    }

    private func addArrangedSubview(from button: FindButton, diameterMultiplier: CGFloat) {
      let container = ButtonContainer()
      container.addSubview(button)
      button.anchorToSuperview()
      addArrangedSubview(container)
      container.translatesAutoresizingMaskIntoConstraints = false
      container.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: diameterMultiplier).isActive = true
      container.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
    }

    @objc
    private func handleTap(_ button: FindButton) {
      delegate?.didTapButton(button: button)
    }


}

private class ButtonContainer: UIView {

  override func draw(_ rect: CGRect) {
    applyShadow(radius: 0.2 * bounds.width, opacity: 0.05, offset: CGSize(width: 0, height: 0.15 * bounds.width))
  }
}


extension UIView {

  @discardableResult
  func anchor(top: NSLayoutYAxisAnchor? = nil,
              left: NSLayoutXAxisAnchor? = nil,
              bottom: NSLayoutYAxisAnchor? = nil,
              right: NSLayoutXAxisAnchor? = nil,
              paddingTop: CGFloat = 0,
              paddingLeft: CGFloat = 0,
              paddingBottom: CGFloat = 0,
              paddingRight: CGFloat = 0,
              width: CGFloat = 0,
              height: CGFloat = 0) -> [NSLayoutConstraint] {
    translatesAutoresizingMaskIntoConstraints = false

    var anchors = [NSLayoutConstraint]()

    if let top = top {
      anchors.append(topAnchor.constraint(equalTo: top, constant: paddingTop))
    }
    if let left = left {
      anchors.append(leftAnchor.constraint(equalTo: left, constant: paddingLeft))
    }
    if let bottom = bottom {
      anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom))
    }
    if let right = right {
      anchors.append(rightAnchor.constraint(equalTo: right, constant: -paddingRight))
    }
    if width > 0 {
      anchors.append(widthAnchor.constraint(equalToConstant: width))
    }
    if height > 0 {
      anchors.append(heightAnchor.constraint(equalToConstant: height))
    }

    anchors.forEach { $0.isActive = true }

    return anchors
  }

  @discardableResult
  func anchorToSuperview() -> [NSLayoutConstraint] {
    return anchor(top: superview?.topAnchor,
                  left: superview?.leftAnchor,
                  bottom: superview?.bottomAnchor,
                  right: superview?.rightAnchor)
  }
}

extension UIView {

  func applyShadow(radius: CGFloat,
                   opacity: Float,
                   offset: CGSize,
                   color: UIColor = .black) {
    layer.shadowRadius = radius
    layer.shadowOpacity = opacity
    layer.shadowOffset = offset
    layer.shadowColor = color.cgColor
  }
}


