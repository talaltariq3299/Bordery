//
//  ExportEngine.swift
//  Bordery
//
//  Created by Kevin Laminto on 17/11/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import Foundation
import UIKit

class ExportEngine {
//    var currentRatio: UIColor = .white
    
    var xCoord: CGFloat
    let yCoord: CGFloat
    let buttonWidth: CGFloat
    let buttonHeight: CGFloat
    
    let gapBetweenButtons: CGFloat = 10
    
    let exportName = ["Camera Roll", "Instagram", "Twitter", "Facebook", "More"]
    let exportIcon = ["cameraRoll-icon","instagram-icon" , "twitter-icon", "facebook-icon", "share-icon"]
    
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
    func createButtonArray() -> [UIButton] {
        var itemCount = 0
        var exportButtons: [UIButton] = [UIButton()]
        
        for i in 0 ..< exportName.count {
            itemCount = i
            
            // button property
            let exportButton = UIButton(type: .custom)
            exportButton.addTarget(self, action: #selector(buttonHighlighted), for: .touchDown)
            exportButton.addTarget(self, action: #selector(buttonNormal), for: .touchDragExit)
            exportButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            exportButton.backgroundColor = .clear
            exportButton.layer.borderColor = .none
            exportButton.tag = itemCount
            exportButton.clipsToBounds = true
            exportButton.tintColor = .white
            
            let buttonImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            buttonImage.image = UIImage(named: exportIcon[i])?.withRenderingMode(.alwaysTemplate)
            buttonImage.contentMode = .scaleAspectFit
            buttonImage.center = CGPoint(x: exportButton.frame.size.width / 2, y: exportButton.frame.size.height * 0.35)
            

            exportButton.addSubview(buttonImage)
            
            let xOffset: CGFloat = 0.5
            let yOffset: CGFloat = 0.65
            
            // create labels
            let ExportLabel = UILabel(frame: CGRect(x: exportButton.frame.width * xOffset, y: exportButton.frame.height * yOffset, width: 85, height: 20))
            ExportLabel.textAlignment = .left
            ExportLabel.text = exportName[i]
            ExportLabel.textColor = UIColor.white
            ExportLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
            ExportLabel.sizeToFit()
            ExportLabel.center = CGPoint(x: exportButton.frame.size.width / 2, y: exportButton.frame.size.height * 0.8)
            
            exportButton.addSubview(ExportLabel)
            
            xCoord += buttonWidth + gapBetweenButtons
            exportButtons.append(exportButton)
        }
        
        return exportButtons
    }
    
    @objc func buttonHighlighted(sender: UIButton!) {
        sender.tintColor = .lightGray
    }
    
    @objc func buttonNormal(sender: UIButton!) {
        sender.tintColor = .white
    }
    
}
