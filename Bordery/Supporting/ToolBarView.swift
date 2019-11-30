//
//  ToolBarView.swift
//  Bordery
//
//  Created by Kevin Laminto on 30/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import Foundation
import UIKit

class ToolBarView {
    var xCoord: CGFloat
    let yCoord: CGFloat
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat
    
    let gapBetweenButtons: CGFloat = 10
    
    let functionName = ["allignment"]
    let allignmentViewImage: [UIImage] = [(UIImage(named: "right-align")?.withRenderingMode(.alwaysTemplate))!, (UIImage(named: "left-align")?.withRenderingMode(.alwaysTemplate))!, (UIImage(named: "center-align")?.withRenderingMode(.alwaysTemplate))!]
    var counter = 0
    
    init(toolbarW: CGFloat, toolbarH: CGFloat) {
        self.xCoord = toolbarW * 0.05
        self.yCoord = toolbarH * 0.5
        self.buttonWidth = toolbarH * 0.5
        self.buttonHeight = toolbarH * 0.5
    }
    
    /**
     Creates an array of buttons of colour picker.
     - Returns: An array of buttons complete with its properties.
     */
    func createButtonArray() -> [UIButton] {
        var itemCount = 0
        var functionButtons: [UIButton] = [UIButton()]
        
        for i in 0 ..< functionName.count {
            itemCount = i + 1
            
            // button property
            let functionButton = UIButton(type: .custom)
            functionButton.backgroundColor = .clear
            functionButton.tintColor = .white
            functionButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonWidth)
            functionButton.tag = itemCount
            functionButton.clipsToBounds = true
            
            functionButton.setImage(allignmentViewImage[0], for: .normal)
            functionButton.imageView?.contentMode = .scaleAspectFit
            
            xCoord += buttonWidth + gapBetweenButtons
            functionButtons.append(functionButton)
        }
        
        return functionButtons
    }
    
}
