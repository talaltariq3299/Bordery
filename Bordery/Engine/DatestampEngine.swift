//
//  DatestampEngine.swift
//  Bordery
//
//  Created by Kevin Laminto on 24/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import Foundation
import UIKit

class DatestampEngine {
    var currentColour: UIColor = UIColor(displayP3Red: 239/255, green: 82/255, blue: 46/255, alpha: 1.0)
    var isHidden = true
    
    var xCoord: CGFloat
    let yCoord: CGFloat
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat
    
    // datestamp properties
    // font from https://allbestfonts.com/date-stamp/
    var dateText = "09 01 '18"
    let dateFont = UIFont(name: "DateStamp", size: 10)
    let dateGlowsize: CGFloat = 0
    
    var currentAllignment: NSTextAlignment = .center
    
    let gapBetweenButtons: CGFloat = 10
    let colourName = [
        ["Crimson", "#DE131A"],
        ["Cinnabar", "#E34A2C"],
        ["Crail", "#C76043"],
        ["Carmine", "#A94333"],
        ["Porsche", "#EEB966"],
        ["Yellow", "#F6EE54"],
    ]
    let functionName = ["Hide/show \ndatestamp", "Edit text"]
    let functionIcon = ["hideshow-icon", "editText-icon"]
    
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
            colourLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
            colourLabel.sizeToFit()
            
            // --------
            let hexLabel = UILabel(frame: CGRect(x: colourButton.frame.width * xOffset, y: colourButton.frame.height * (yOffset + 0.15), width: 80, height: 20))
            hexLabel.textAlignment = .left
            hexLabel.text = colourName[i][1]
            hexLabel.font = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.light)
            
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
    func createDateFunction() -> [UIButton] {
        var itemCount = 98
        let xOffset: CGFloat = 0.5
        let yOffset: CGFloat = 0.65
        var functionButtons: [UIButton] = []

        // button property
        for i in 0 ..< functionName.count {
            itemCount += 1
            let hideShowButton = UIButton(type: .custom)
            hideShowButton.addTarget(self, action: #selector(buttonHighlighted), for: .touchDown)
            hideShowButton.addTarget(self, action: #selector(buttonNormal), for: .touchDragExit)
            hideShowButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            hideShowButton.backgroundColor = .clear
            hideShowButton.layer.borderColor = .none
            hideShowButton.tag = itemCount
            hideShowButton.clipsToBounds = true
            hideShowButton.tintColor = .white
            
            if i < functionIcon.count {
                let buttonImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
                buttonImage.image = UIImage(named: functionIcon[i])?.withRenderingMode(.alwaysTemplate)
                buttonImage.contentMode = .scaleAspectFit
                buttonImage.center = CGPoint(x: hideShowButton.frame.size.width / 2, y: hideShowButton.frame.size.height * 0.35)
                hideShowButton.addSubview(buttonImage)
            }

            // create labels
            let exportLabel = UILabel(frame: CGRect(x: hideShowButton.frame.width * xOffset, y: hideShowButton.frame.height * yOffset, width: 85, height: 20))
            exportLabel.textAlignment = .center
            exportLabel.numberOfLines = 0
            exportLabel.text = functionName[i]
            exportLabel.textColor = UIColor.white
            exportLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
            exportLabel.sizeToFit()
            exportLabel.center = CGPoint(x: hideShowButton.frame.size.width / 2, y: hideShowButton.frame.size.height * 0.8)
            
            hideShowButton.addSubview(exportLabel)
            
            xCoord += buttonWidth + gapBetweenButtons
            functionButtons.append(hideShowButton)
        }
        
        let border = UIButton(type: .custom)
        border.autoresizingMask = [.flexibleRightMargin]
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
        datestamp.text = dateText
        datestamp.addCharacterSpacing(kernValue: 1.4)
        datestamp.font = dateFont
        datestamp.textAlignment = currentAllignment
        datestamp.numberOfLines = 0
        
        datestamp.glowSize = dateGlowsize
        datestamp.blurColor = UIColor(displayP3Red: 250/255, green: 80/255, blue: 32/255, alpha: 1.0)
        datestamp.textColor = currentColour
        
        return datestamp
    }
    
    
    @objc func buttonHighlighted(sender: UIButton!) {
        sender.tintColor = .lightGray
    }
    
    @objc func buttonNormal(sender: UIButton!) {
        sender.tintColor = .white
    }
    
    
}
