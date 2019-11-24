//
//  MenuBar.swift
//  Bordery
//
//  Created by Kevin Laminto on 24/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import Foundation
import UIKit

// Responsible to create the menu bar. 
struct MenuBarButton {
    static func createButton(buttonIcon: UIImage, buttonTag: Int, isActive: Bool) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        button.backgroundColor = .clear
        button.tag = buttonTag
        button.tintColor = isActive ? .white : .darkGray
        
        let buttonImageView = UIImageView(frame: (CGRect(x: 0, y: 0, width: 25, height: 25)))
        buttonImageView.image = buttonIcon
        buttonImageView.contentMode = .scaleAspectFit
        
        button.addSubview(buttonImageView)
        
        buttonImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonImageView.centerXAnchor.constraint(equalTo: button.centerXAnchor, constant: 0),
            buttonImageView.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: 0),
            buttonImageView.heightAnchor.constraint(equalToConstant: 20),
            buttonImageView.widthAnchor.constraint(equalToConstant: 20)
        ])
        

        
        return button
    }
}
