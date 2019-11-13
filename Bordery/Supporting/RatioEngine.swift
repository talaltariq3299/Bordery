//
//  RatioEngine.swift
//  Bordery
//
//  Created by Kevin Laminto on 12/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import Foundation
import UIKit

struct RatioEngine {
//    var currentRatio: UIColor = .white
    
    var xCoord: CGFloat
    let yCoord: CGFloat
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat
    
    let gapBetweenButtons: CGFloat = 10
    
    let ratioName = ["Original", "Square"]
    
    init(editorViewW: CGFloat, editorViewH: CGFloat, viewFrameH: CGFloat, heightMultConst: CGFloat) {
        self.xCoord = editorViewW * 0.02
        self.yCoord = editorViewH * 0.17
        self.buttonWidth = editorViewH * 0.4
        self.buttonHeight = viewFrameH * heightMultConst * 0.68
    }
    
    
    /**
     Creates an array of buttons of colour picker.
     - Returns: An array of buttons complete with its properties.
     */
    mutating func createButtonArray() -> [UIButton] {
        var itemCount = 0
        var ratioButtons: [UIButton] = [UIButton()]
        
        for i in 0 ..< ratioName.count {
            itemCount = i
            
            // button property
            let ratioButton = UIButton(type: .custom)
            ratioButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            ratioButton.backgroundColor = UIColor.black
            ratioButton.layer.borderColor = .none
            ratioButton.tag = itemCount
            ratioButton.clipsToBounds = true
            
            let xOffset: CGFloat = 0.025
            let yOffset: CGFloat = 0.55
            
            // create labels
            let ratioLabel = UILabel(frame: CGRect(x: ratioButton.frame.width * xOffset, y: ratioButton.frame.height * yOffset, width: 85, height: 20))
            ratioLabel.textAlignment = .left
            ratioLabel.text = ratioName[i]
            ratioLabel.textColor = UIColor.white
            ratioLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.bold)
            ratioLabel.sizeToFit()
            
            ratioButton.addSubview(ratioLabel)
            
            xCoord += buttonWidth + gapBetweenButtons
            ratioButtons.append(ratioButton)
        }
        
        return ratioButtons
    }
    
}

