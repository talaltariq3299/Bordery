//
//  BarItemEdit.swift
//  Bordery
//
//  Created by Kevin Laminto on 24/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import Foundation
import UIKit

struct BarItemEdit {
    
    static func createBarItemButton(title: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.backgroundColor = .clear
        button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        return button
    }
    
}


//let cancelButton = UIButton(type: .custom)
//cancelButton.setTitle("☓", for: .normal)
//cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
//cancelButton.addTarget(self, action: #selector(buttonHighlighted), for: .touchDown)
//cancelButton.addTarget(self, action: #selector(buttonNormal), for: .touchDragExit)
//cancelButton.backgroundColor = .clear
//cancelButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//
//let cancelButtonWrapper = UIView()
//cancelButton.translatesAutoresizingMaskIntoConstraints = false
//cancelButtonWrapper.addSubview(cancelButton)
//
//NSLayoutConstraint.activate([
//    cancelButton.topAnchor.constraint(equalTo: cancelButtonWrapper.topAnchor, constant: 5),
//    cancelButton.bottomAnchor.constraint(equalTo: cancelButtonWrapper.bottomAnchor, constant: -5),
//    cancelButton.leftAnchor.constraint(equalTo: cancelButtonWrapper.leftAnchor, constant: 5),
//    cancelButton.rightAnchor.constraint(equalTo: cancelButtonWrapper.rightAnchor, constant: -5)
//])
