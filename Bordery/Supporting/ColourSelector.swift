//
//  ColourSelector.swift
//  Bordery
//
//  Created by Kevin Laminto on 11/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import Foundation
import UIKit

struct ColourSelector {
    var xCoord: CGFloat
    let yCoord: CGFloat
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat
    
    let gapBetweenButtons: CGFloat = 5
    let colourName = [
        ["white", "#FFFFFF"],
        ["black", "#000000"],
        ["White Bone", "#E0D8C3"],
        ["Forest Green", "#065125"],
        ["Gold", "#DDA033"],
        ["Red Flame", "#E2532F"],
        ["Blue munsell", "#0D97AC"],
    ]
    
    init(editorViewW: CGFloat, editorViewH: CGFloat, viewFrameH: CGFloat, heightMultConst: CGFloat) {
        self.xCoord = editorViewW * 0.02
        self.yCoord = editorViewH * 0.15
        self.buttonWidth = editorViewH * 0.4
        self.buttonHeight = viewFrameH * heightMultConst * 0.7
    }
    
    mutating func createButtonArray() -> [UIButton] {
        var itemCount = 0
        var colourButtons: [UIButton] = [UIButton()]
        
        for i in 0 ..< colourName.count {
            itemCount = i
            let hexUIColor: UIColor = hexStringToUIColor(hex: colourName[i][1])
            
            // button property
            let colourButton = UIButton(type: .custom)
            colourButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            colourButton.backgroundColor = hexUIColor
            colourButton.layer.borderColor = .none
            colourButton.tag = itemCount
            colourButton.clipsToBounds = true
            colourButton.setTitle(colourName[i][0], for: .normal)

            // change the text colour for contrast
            switch colourName[i][1] {
                case "#FFFFFF", "#E0D8C3":
                    colourButton.setTitleColor(.black, for: .normal)
                    
                default:
                    colourButton.setTitleColor(.white, for: .normal)
            }
            
            xCoord += buttonWidth + gapBetweenButtons
            colourButtons.append(colourButton)
        }
        
        return colourButtons
    }
    
    
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
    
}
