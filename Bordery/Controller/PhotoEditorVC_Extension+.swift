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
        let adjusmentName = AdjustmentEngine.adjusmentName
        
        let gapBetweenButtons: CGFloat = 5
        
        var itemCount = 0
        for i in 0..<adjusmentName.count {
            itemCount = i
            // Button properties
            let adjustmentButton = UIButton(type: .custom)
            adjustmentButton.frame = CGRect(x: xCoord, y: yCoord, width: buttonWidth, height: buttonHeight)
            adjustmentButton.backgroundColor = UIColor(named:"backgroundSecondColor")
            adjustmentButton.tag = itemCount
            adjustmentButton.addTarget(self, action: #selector(adjustmentTapped), for: .touchUpInside)
            adjustmentButton.layer.cornerRadius = 6
            adjustmentButton.clipsToBounds = true
            
            adjustmentButton.setTitle(adjusmentName[i], for: .normal)
            
            // Add Buttons in the Scroll View
            xCoord +=  buttonWidth + gapBetweenButtons
            adjustmentFiltersScrollView.addSubview(adjustmentButton)
        }
        
        // resize the scrollView to match the content.
        adjustmentFiltersScrollView.contentSize = CGSize(width: buttonWidth * CGFloat(itemCount + 2), height: adjustmentFiltersScrollView.frame.height)
        
    }
    
    @objc func adjustmentTapped(sender: UIButton) {
        adjustmentNameLabel.text = sender.title(for: .normal)
        
        adjustmentFiltersScrollView.isHidden = true
        adjustmentSliderOutlet.tag = sender.tag
        
        hide(progress: nil, barItemOnEdit: false, ui: nil, slider: false)
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
    
    // create a slider for adjusting the image
    func setupAdjustmentSlider() {
        adjustmentSliderOutlet.maximumValue = 0.4
        adjustmentSliderOutlet.minimumValue = 0.0
        adjustmentSliderOutlet.value = Float(adjustmentEngine.imgSizeMultiplier)
        
        adjustmentSliderOutlet.maximumTrackTintColor = UIColor(named: "backgroundSecondColor")
        adjustmentSliderOutlet.minimumTrackTintColor = UIColor.gray
        adjustmentSliderOutlet.thumbTintColor = UIColor.white
    }
    
    // MARK: - Hide elements function
    func hide(progress: Bool?, barItemOnEdit: Bool?, ui: Bool?, slider: Bool?) {
        if let progress = progress {
            self.progressDownloadingLabel.isHidden = progress
            self.progressPercentageLabel.isHidden = progress
            self.progressBarOutlet.isHidden = progress
        }
        if let barItemOnEdit = barItemOnEdit {
            barItemOnEditStackView.isHidden = barItemOnEdit
        }
        if let ui = ui {
            editorView.isHidden = ui
            barView.isHidden = ui
        }
        if let slider = slider {
            adjustmentFiltersScrollView.isHidden = !slider
            adjustmentSliderOutlet.isHidden = slider
        }
    }
    
    // MARK: - Constraints
    // create constraint
    func setupConstraint() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.6)
            ])
        
        progressStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressStackView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            progressStackView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            ])
        
        editorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editorView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            editorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            editorView.leftAnchor.constraint(equalTo: view.leftAnchor),
            editorView.rightAnchor.constraint(equalTo: view.rightAnchor),
            editorView.heightAnchor.constraint(equalToConstant: view.frame.height * VIEW_HEIGHTMULTIPLIER_CONSTANT)
            ])

        barView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            barView.topAnchor.constraint(equalTo: editorView.bottomAnchor),
            barView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            barView.leftAnchor.constraint(equalTo: view.leftAnchor),
            barView.rightAnchor.constraint(equalTo: view.rightAnchor),
            barView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        
        adjustmentSliderOutlet.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            adjustmentSliderOutlet.centerXAnchor.constraint(equalTo: editorView.centerXAnchor),
            adjustmentSliderOutlet.centerYAnchor.constraint(equalTo: editorView.centerYAnchor),
            adjustmentSliderOutlet.widthAnchor.constraint(equalToConstant: editorView.frame.height * 1.5)
        ])
    }
    
    
}
