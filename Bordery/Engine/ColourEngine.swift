//
//  ColourSelector.swift
//  Bordery
//
//  Created by Kevin Laminto on 11/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import Foundation
import UIKit

struct ColourEngine {
    var currentColour: UIColor = .white
    
    var xCoord: CGFloat
    let yCoord: CGFloat
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat
    
    let gapBetweenButtons: CGFloat = 10
    let colourName = [
        ["white", "#FFFFFF"],
        ["White Bone", "#E0D8C3"],
        ["black", "#000000"],
        ["Uspdell Red", "#AD242C"], //R
        ["Orange Flame", "#E2532F"], //O
        ["Gold", "#DDA033"], // Y
        ["Forest Green", "#065125"], // G
        ["Blue munsell", "#0D97AC"], // B
        ["Rhino Blue", "#354065"], // I
        ["Violet Purple", "#272961"], // V
        
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
        
        for i in 0 ..< colourName.count {
            itemCount = i
            let hexUIColor: UIColor = hexStringToUIColor(hex: colourName[i][1])
            
            // button property
            let colourButton = UIButton(type: .custom)
            colourButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonWidth)
            colourButton.backgroundColor = hexUIColor
            colourButton.layer.borderColor = .none
            colourButton.tag = itemCount
            colourButton.clipsToBounds = true
            
            let xOffset: CGFloat = 0.025
            let yOffset: CGFloat = 0.55
            
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
            switch colourName[i][1] {
                case "#FFFFFF", "#E0D8C3":
                    colourLabel.textColor = UIColor.black
                    hexLabel.textColor = UIColor.black
                    colourButton.titleLabel?.textColor = .black
                default:
                    colourLabel.textColor = UIColor.white
                    hexLabel.textColor = UIColor.white
                colourButton.titleLabel?.textColor = .white
            }
            
            
            colourButton.addSubview(colourLabel)
            colourButton.addSubview(hexLabel)
            
            xCoord += buttonWidth + gapBetweenButtons
            colourButtons.append(colourButton)
        }
        
        return colourButtons
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
    
    
    /**
     Creates a colour based on the image
     - Parameters:
        - image: The user's picked image
     - Returns: A button (array)
     */
    mutating func colorFromImage(image: UIImage) -> [UIButton] {
        var masterButton: [UIButton] = [UIButton]()
        
        let border = UIButton(type: .custom)
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: xCoord, y: yCoord, width: 1, height: buttonHeight)
        border.backgroundColor = UIColor(named: "backgroundSecondColor")
        border.clipsToBounds = true
        
        xCoord += gapBetweenButtons
        masterButton.append(border)

        let xOffset: CGFloat = 0.025
        let yOffset: CGFloat = 0.55
        // --------
        let color = image.averageColor
        
        // button property
        let colourButton = UIButton(type: .custom)
        colourButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonWidth)
        colourButton.backgroundColor = color
        colourButton.layer.borderColor = .none
        colourButton.clipsToBounds = true
        
        // create labels
        let colourLabel = UILabel(frame: CGRect(x: colourButton.frame.width * xOffset, y: colourButton.frame.height * yOffset * 0.65, width: 85, height: 20))
        colourLabel.textAlignment = .left
        colourLabel.text = "Colour\nfrom image"
        colourLabel.numberOfLines = 0
        colourLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.bold)
        colourLabel.sizeToFit()

        // --------
        let hexLabel = UILabel(frame: CGRect(x: colourButton.frame.width * xOffset, y: colourButton.frame.height * (yOffset + 0.15), width: 80, height: 20))
        hexLabel.textAlignment = .left
        hexLabel.text = color?.hexString
        hexLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
        
        // colour for better usability
        let textColour = colourButton.backgroundColor?.isDarkColor == true ? UIColor.white : UIColor.black
        colourLabel.textColor = textColour
        hexLabel.textColor = textColour

        colourButton.addSubview(colourLabel)
        colourButton.addSubview(hexLabel)
        
        xCoord += buttonWidth + gapBetweenButtons
        masterButton.append(colourButton)

        return masterButton
    }
    
}
