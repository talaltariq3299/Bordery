//
//  MainButton.swift
//  Bordery
//
//  Created by Kevin Laminto on 24/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import Foundation
import UIKit

// Responsible to create the main button.
struct MainButton {
    static func createButton(buttonIcon: UIImage, buttonName: String) -> UIButton {
        let buttonSize = 100
        let imageViewSize = 30
        let labelSize = 40
        let textSize: CGFloat = 13
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize))
        button.backgroundColor = .clear
        
        let buttonImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageViewSize, height: imageViewSize))
        buttonImageView.image = buttonIcon
        buttonImageView.contentMode = .scaleAspectFit
        buttonImageView.center = button.convert(button.center, to: buttonImageView.superview)
        button.tintColor = .white
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: labelSize, height: labelSize))
        label.textAlignment = .center
        label.text = buttonName
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: textSize, weight: UIFont.Weight.regular)
        
        button.addSubview(buttonImageView)
        button.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: 30)
        ])
        
        return button
    }
    
    
}
