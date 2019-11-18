//
//  RatioEngine.swift
//  Bordery
//
//  Created by Kevin Laminto on 12/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import Foundation
import UIKit

class RatioEngine {
    var xCoord: CGFloat
    let yCoord: CGFloat
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat
    
    let gapBetweenButtons: CGFloat = 10
    
    let ratioName = ["Original", "Square"]
    let ratioIcon = ["original-icon", "square-icon"]
    
    init(editorViewW: CGFloat, editorViewH: CGFloat, viewFrameH: CGFloat, heightMultConst: CGFloat) {
        self.xCoord = editorViewW * 0.02
        self.yCoord = editorViewH * 0.23
        self.buttonWidth = editorViewH * 0.4
        self.buttonHeight = viewFrameH * heightMultConst * 0.60
    }
    
    
    /**
     Creates an array of buttons of colour picker.
     - Returns: An array of buttons complete with its properties.
     */
    func createButtonArray() -> [UIButton] {
        var itemCount = 0
        var ratioButtons: [UIButton] = [UIButton()]
        
        for i in 0 ..< ratioName.count {
            itemCount = i
            
            // button property
            let ratioButton = UIButton(type: .custom)
            ratioButton.addTarget(self, action: #selector(buttonHighlighted), for: .touchDown)
            ratioButton.addTarget(self, action: #selector(buttonNormal), for: .touchDragExit)
            ratioButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            ratioButton.backgroundColor = .clear
            ratioButton.layer.borderColor = .none
            ratioButton.tag = itemCount
            ratioButton.clipsToBounds = true
            ratioButton.tintColor = .white
            
            let buttonImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 35, height: 35))
            buttonImage.image = UIImage(named: ratioIcon[i])?.withRenderingMode(.alwaysTemplate)
            buttonImage.contentMode = .scaleAspectFit
            buttonImage.center = CGPoint(x: ratioButton.frame.size.width / 2, y: ratioButton.frame.size.height * 0.35)
            

            ratioButton.addSubview(buttonImage)
            
            let xOffset: CGFloat = 0.5
            let yOffset: CGFloat = 0.65
            
            // create labels
            let ratioLabel = UILabel(frame: CGRect(x: ratioButton.frame.width * xOffset, y: ratioButton.frame.height * yOffset, width: 85, height: 20))
            ratioLabel.textAlignment = .center
            ratioLabel.text = ratioName[i]
            ratioLabel.textColor = UIColor.white
            ratioLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
            ratioLabel.sizeToFit()
            ratioLabel.center = CGPoint(x: ratioButton.frame.size.width / 2, y: ratioButton.frame.size.height * 0.8)
            
            ratioButton.addSubview(ratioLabel)
            
            
            xCoord += buttonWidth + gapBetweenButtons
            ratioButtons.append(ratioButton)
        }
        
        return ratioButtons
    }
    
    @objc func buttonHighlighted(sender: UIButton!) {
        sender.tintColor = .lightGray
    }
    
    @objc func buttonNormal(sender: UIButton!) {
        sender.tintColor = .white
    }
    
}

