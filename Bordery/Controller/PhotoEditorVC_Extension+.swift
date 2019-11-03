//
//  PhotoEditorVC_Extension+.swift
//  Bordery
//
//  Created by Kevin Laminto on 5/7/19.
//  Copyright © 2019 Kevin Laminto. All rights reserved.
//

import Foundation
import UIKit

extension PhotoEditorViewController {
    
    // MARK: - Adjustment View
    // create adjustment filters scrollview
    func setupAdjustmentView() {
        editorView.addSubview(adjustmentFiltersScrollView)
        adjustmentFiltersScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            adjustmentFiltersScrollView.topAnchor.constraint(equalTo: editorView.topAnchor),
            adjustmentFiltersScrollView.leftAnchor.constraint(equalTo: editorView.leftAnchor),
            adjustmentFiltersScrollView.rightAnchor.constraint(equalTo: editorView.rightAnchor),
            adjustmentFiltersScrollView.bottomAnchor.constraint(equalTo: editorView.bottomAnchor)
        ])
        
        adjustmentFiltersScrollView.showsHorizontalScrollIndicator = false
        
        // adjustments button
        var xCoord: CGFloat = editorView.frame.width * 0.02
        let yCoord: CGFloat = editorView.frame.height * 0.02
        let buttonWidth:CGFloat = editorView.frame.height * 0.4
        let buttonHeight: CGFloat = view.frame.height * VIEW_HEIGHTMULTIPLIER_CONSTANT * 0.85
        
        let gapBetweenButtons: CGFloat = 5
        
        var itemCount = 0
        for i in 0..<2 {
            itemCount = i
            // Button properties
            let adjustmentButton = UIButton(type: .custom)
            adjustmentButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            adjustmentButton.backgroundColor = UIColor(named:"backgroundSecondColor")
            adjustmentButton.tag = itemCount
            //            adjustmentButton.addTarget(self, action: #selector(adjustmentTapped), for: .touchUpInside)
            adjustmentButton.layer.cornerRadius = 6
            adjustmentButton.clipsToBounds = true
            
            adjustmentButton.setTitle(String(itemCount), for: .normal)
            
            // Add Buttons in the Scroll View
            xCoord +=  buttonWidth + gapBetweenButtons
            adjustmentFiltersScrollView.addSubview(adjustmentButton)
        }
        
        // resize the scrollView to match the content.
        adjustmentFiltersScrollView.contentSize = CGSize(width: buttonWidth * CGFloat(itemCount + 2), height: adjustmentFiltersScrollView.frame.height)
        
    }
    
    // create bar items to present option to proceed or not on an edit
    func setupBarItemOnEdit() {
        barItemOnEditStackView.translatesAutoresizingMaskIntoConstraints = false
        barItemOnEditStackView.axis = .horizontal
        barItemOnEditStackView.distribution = .fillProportionally
        barView.addSubview(barItemOnEditStackView)
        
        NSLayoutConstraint.activate([
            barItemOnEditStackView.topAnchor.constraint(equalTo: barView.topAnchor),
            barItemOnEditStackView.leftAnchor.constraint(equalTo: barView.leftAnchor),
            barItemOnEditStackView.rightAnchor.constraint(equalTo: barView.rightAnchor),
            barItemOnEditStackView.bottomAnchor.constraint(equalTo: barView.bottomAnchor),
        ])
        
        let cancelButton = UIButton(type: .custom)
        cancelButton.setTitle("☓", for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        cancelButton.backgroundColor = UIColor(named: "backgroundColor")
        cancelButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        cancelButton.layer.cornerRadius = 20
        
        let cancelButtonWrapper = UIView()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButtonWrapper.addSubview(cancelButton)
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: cancelButtonWrapper.topAnchor, constant: 5),
            cancelButton.bottomAnchor.constraint(equalTo: cancelButtonWrapper.bottomAnchor, constant: -5),
            cancelButton.leftAnchor.constraint(equalTo: cancelButtonWrapper.leftAnchor, constant: 5),
            cancelButton.rightAnchor.constraint(equalTo: cancelButtonWrapper.rightAnchor, constant: -5)
        ])
        
        let checkButton = UIButton(type: .custom)
        checkButton.setTitle("✓", for: .normal)
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        checkButton.backgroundColor = UIColor(named: "backgroundColor")
        checkButton.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        checkButton.layer.cornerRadius = 20
        
        let checkButtonWrapper = UIView()
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButtonWrapper.addSubview(checkButton)
        
        NSLayoutConstraint.activate([
            checkButton.topAnchor.constraint(equalTo: checkButtonWrapper.topAnchor, constant: 5),
            checkButton.bottomAnchor.constraint(equalTo: checkButtonWrapper.bottomAnchor, constant: -5),
            checkButton.leftAnchor.constraint(equalTo: checkButtonWrapper.leftAnchor, constant: 5),
            checkButton.rightAnchor.constraint(equalTo: checkButtonWrapper.rightAnchor, constant: -5)
        ])
        
        barItemOnEditStackView.addArrangedSubview(cancelButtonWrapper)
        barItemOnEditStackView.addArrangedSubview(checkButtonWrapper)
        
        
    }
    
    // MARK: - Hide elements function
    // hide progress function
    func hideProgress(bool: Bool) {
        self.progressDownloadingLabel.isHidden = bool
        self.progressPercentageLabel.isHidden = bool
        self.progressBarOutlet.isHidden = bool
    }
    
    // hide slider attributes
    func hideSlider(bool: Bool) {
        adjustmentNameLabel.isHidden = bool
        sliderValueLabel.isHidden = bool
        sliderValueLabel.text = ""
    }
    
    // hide barItemOnEdit
    func hideBarItemOnEdit(bool: Bool) {
        barItemOnEditStackView.isHidden = bool
    }
    
    func hideUI(bool: Bool) {
        editorView.isHidden = bool
        barView.isHidden = bool
    }
    
}
