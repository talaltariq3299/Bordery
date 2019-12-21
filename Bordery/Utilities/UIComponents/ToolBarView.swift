//
//  ToolBarView.swift
//  Bordery
//
//  Created by Kevin Laminto on 30/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import Foundation
import UIKit
import BonMot

class ToolBarView {
    var xCoord: CGFloat
    let yCoord: CGFloat
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat
    
    let gapBetweenButtons: CGFloat = 25
    
    let functionName = ["allignment", "font"]
    let allignmentViewImage: [UIImage] = [(UIImage(named: "right-align")?.withRenderingMode(.alwaysTemplate))!, (UIImage(named: "left-align")?.withRenderingMode(.alwaysTemplate))!, (UIImage(named: "center-align")?.withRenderingMode(.alwaysTemplate))!]
    
    let functionIcon: [UIImage] = [
                        (UIImage(named: "right-align")?.withRenderingMode(.alwaysTemplate))!,
                        (UIImage(named: "changeFont-icon")?.withRenderingMode(.alwaysTemplate))!,
                        ]
    

    let fontNames: [UIFont] = [
                                UIFont(name: "DateStamp-Bold", size: 20)!,
                                UIFont(name: "BodoniSvtyTwoITCTT-Book", size: 20)!,
                                UIFont(name: "Cochin", size: 20)!,
                                UIFont(name: "Didot", size: 20)!,
                                UIFont(name: "STHeitiTC-Light", size: 20)!,
                                UIFont(name: "HelveticaNeue", size: 30)!,
                                UIFont(name: "Optima-Regular", size: 20)!,
                                UIFont(name: "Palatino-Roman", size: 20)!,
                                ]
    
    init(toolbarW: CGFloat, toolbarH: CGFloat) {
        self.xCoord = toolbarW * 0.05
        self.yCoord = toolbarH * 0.5
        self.buttonWidth = toolbarH * 0.5
        self.buttonHeight = toolbarH * 0.5
    }
    
    /**
     Creates an array of buttons of datestamp functions.
     - Returns: An array of buttons complete with its properties.
     */
    func createButtonArray() -> [UIButton] {
        var localxCoord = xCoord
        var itemCount = 0
        var functionButtons: [UIButton] = [UIButton()]
        
        for i in 0 ..< functionName.count {
            itemCount = i + 1
            
            // button property
            let functionButton = UIButton(type: .custom)
            functionButton.backgroundColor = .clear
            functionButton.tintColor = .white
            functionButton.frame = CGRect(x: localxCoord, y: yCoord, width: buttonWidth, height: buttonWidth)
            functionButton.tag = itemCount
            functionButton.clipsToBounds = true
            
            functionButton.setImage(functionIcon[i], for: .normal)
            functionButton.imageView?.contentMode = .scaleAspectFit
            
            localxCoord += buttonWidth + gapBetweenButtons
            functionButtons.append(functionButton)
        }
        
        return functionButtons
    }
    
    func createFontArray() -> [UIButton] {
        var localxCoord = xCoord
        let itemCount = 99
        var fontArray = [UIButton]()
        
        for i in 0 ..< fontNames.count {
            // create the buttons
            let fontButton = UIButton(type: .custom)
            fontButton.backgroundColor = .clear
            fontButton.tintColor = .white
            fontButton.frame = CGRect(x: localxCoord, y: yCoord, width: buttonWidth * 3, height: buttonWidth * 2)
            fontButton.tag = itemCount
            fontButton.clipsToBounds = true
            let a = fontNames[i].familyName
            let style = StringStyle(
                .color(.white),
                .font(fontNames[i])
            )
            fontButton.setAttributedTitle(a.styled(with: style), for: .normal)

            fontButton.titleLabel?.numberOfLines = 1
            fontButton.titleLabel?.adjustsFontSizeToFitWidth = true
            fontButton.titleLabel?.baselineAdjustment = .alignCenters
            
            localxCoord += buttonWidth * 3 + gapBetweenButtons
            fontArray.append(fontButton)
        }

        
        return fontArray
    }
    
}
