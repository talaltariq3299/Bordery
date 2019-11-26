//
//  DatestampEngine.swift
//  Bordery
//
//  Created by Kevin Laminto on 24/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import Foundation
import UIKit

struct DatestampEngine {
    var currentColour: UIColor = .white
    
    var xCoord: CGFloat
    let yCoord: CGFloat
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat
    
    let gapBetweenButtons: CGFloat = 10
    let colourName = [
        ["Cinnabar", "#E34A2C"],
        ["Orange", "#b35b20"]
    ]
    
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
    mutating func createButtonArray() -> [UIButton] {
        var itemCount = 0
        var colourButtons: [UIButton] = [UIButton()]
        let xOffset: CGFloat = 0.025
        let yOffset: CGFloat = 0.55
        
        for i in 0 ..< colourName.count {
            itemCount = i + 1
            let hexUIColor: UIColor = hexStringToUIColor(hex: colourName[i][1])
            
            // button property
            let colourButton = UIButton(type: .custom)
            colourButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            colourButton.backgroundColor = hexUIColor
            colourButton.layer.borderColor = .none
            colourButton.tag = itemCount
            colourButton.clipsToBounds = true
            
            
            // create labels
            let colourLabel = UILabel(frame: CGRect(x: colourButton.frame.width * xOffset, y: colourButton.frame.height * yOffset, width: 85, height: 20))
            colourLabel.textAlignment = .left
            colourLabel.text = colourName[i][0]
            colourLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.bold)
            colourLabel.sizeToFit()
            
            // --------
            let hexLabel = UILabel(frame: CGRect(x: colourButton.frame.width * xOffset, y: colourButton.frame.height * (yOffset + 0.15), width: 80, height: 20))
            hexLabel.textAlignment = .left
            hexLabel.text = colourName[i][1]
            hexLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
            
            // colour for better usability
            let textColour = colourButton.backgroundColor?.isDarkColor == true ? UIColor.white : UIColor.black
            colourLabel.textColor = textColour
            hexLabel.textColor = textColour
            
            colourButton.addSubview(colourLabel)
            colourButton.addSubview(hexLabel)
            
            xCoord += buttonWidth + gapBetweenButtons
            colourButtons.append(colourButton)
        }
        
        return colourButtons
    }
    
    /**
     Creates an array of buttons of date function.
     - Returns: An array of buttons complete with its properties.
     */
    mutating func createDateFunction() -> [UIButton] {
        let itemCount = 99
        var functionButtons: [UIButton] = []
        let xOffset: CGFloat = 0.5
        let yOffset: CGFloat = 0.5

        
        // create hide/show datestamp button
        let hideShowButton = UIButton(type: .custom)
        hideShowButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
        hideShowButton.backgroundColor = .black
        hideShowButton.layer.borderColor = .none
        hideShowButton.tag = itemCount
        hideShowButton.clipsToBounds = true
        
        // create labels
        let label = UILabel(frame: CGRect(x: hideShowButton.frame.width * xOffset, y: hideShowButton.frame.height * yOffset, width: 85, height: 20))
        label.textAlignment = .center
        label.text = "Hide/show"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        label.sizeToFit()
        label.center =  CGPoint(x: hideShowButton.frame.size.width / 2, y: hideShowButton.frame.size.height * 0.5)
        
        hideShowButton.addSubview(label)
        
        xCoord += buttonWidth + gapBetweenButtons
        functionButtons.append(hideShowButton)
        
        let border = UIButton(type: .custom)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        border.frame = CGRect(x: xCoord, y: yCoord, width: 1, height: buttonHeight)
        border.backgroundColor = UIColor(named: "backgroundSecondColor")
        border.clipsToBounds = true

        xCoord += gapBetweenButtons
        functionButtons.append(border)
        
        
        return functionButtons
    }
    
    /**
     Convert hexadecimal value to UIColor.
     - Parameters:
     - hex: a hex string. ie: "#ffffff"
     - Returns: the UIColor variable.
     */
    fileprivate func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    func datestamp() -> UILabel {
        let datestamp = GlowingLabel(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        datestamp.backgroundColor = .clear
        datestamp.text = "14 08 '99"
        datestamp.font = UIFont(name: "digitaldream", size: 7.5)
        datestamp.textAlignment = .center
        datestamp.numberOfLines = 0
        
        datestamp.glowSize = 7
        datestamp.blurColor = UIColor(displayP3Red: 250/255, green: 80/255, blue: 32/255, alpha: 1.0)
        datestamp.textColor = currentColour
        
        
        return datestamp
    }
    
    
    
}
