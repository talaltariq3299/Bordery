//
//  ExportEngine.swift
//  Bordery
//
//  Created by Kevin Laminto on 17/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import Foundation
import UIKit

struct ExportEngine {
//    var currentRatio: UIColor = .white
    
    var xCoord: CGFloat
    let yCoord: CGFloat
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat
    
    let gapBetweenButtons: CGFloat = 10
    
    let exportName = ["Camera Roll"]
    
    init(editorViewW: CGFloat, editorViewH: CGFloat, viewFrameH: CGFloat, heightMultConst: CGFloat) {
        self.xCoord = editorViewW * 0.02
        self.yCoord = editorViewH * 0.23
        self.buttonWidth = editorViewH * 0.4
        self.buttonHeight = viewFrameH * heightMultConst * 0.60
    }
    
    
    /**
     Creates an array of buttons of Exports
     - Returns: An array of buttons complete with its properties.
     */
    mutating func createButtonArray() -> [UIButton] {
        var itemCount = 0
        var exportButtons: [UIButton] = [UIButton()]
        
        for i in 0 ..< exportName.count {
            itemCount = i
            
            // button property
            let exportButton = UIButton(type: .custom)
            exportButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            exportButton.backgroundColor = UIColor.black
            exportButton.layer.borderColor = .none
            exportButton.tag = itemCount
            exportButton.clipsToBounds = true
            
            let xOffset: CGFloat = 0.025
            let yOffset: CGFloat = 0.55
            
            // create labels
            let ExportLabel = UILabel(frame: CGRect(x: exportButton.frame.width * xOffset, y: exportButton.frame.height * yOffset, width: 85, height: 20))
            ExportLabel.textAlignment = .left
            ExportLabel.text = exportName[i]
            ExportLabel.textColor = UIColor.white
            ExportLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.bold)
            ExportLabel.sizeToFit()
            
            exportButton.addSubview(ExportLabel)
            
            xCoord += buttonWidth + gapBetweenButtons
            exportButtons.append(exportButton)
        }
        
        return exportButtons
    }
    
}
