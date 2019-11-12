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
    
    // main buttons for the app
    func setupMainButtons() {
        // variables
        let sizeIcon = UIImage(named: "size-icon")!.withRenderingMode(.alwaysTemplate)
        let colourIcon = UIImage(named: "colour-icon")!.withRenderingMode(.alwaysTemplate)
        let ratioIcon = UIImage(named: "ratio-icon")!.withRenderingMode(.alwaysTemplate)

        let buttonSize = 100
        let imageViewSize = 30
        let labelSize = 40
        let textSize: CGFloat = 13
        
        // --------
        sizeButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize))
        sizeButton.backgroundColor = .clear
        sizeButton.addTarget(self, action: #selector(sizeButtonTapped), for: .touchUpInside)
        
        let sizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageViewSize, height: imageViewSize))
        sizeImageView.image = sizeIcon
        sizeImageView.tintColor = UIColor.white
        sizeImageView.contentMode = .scaleAspectFit
        sizeImageView.center = sizeButton.convert(sizeButton.center, to: sizeImageView.superview)
        
        let sizeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: labelSize, height: labelSize))
        sizeLabel.textAlignment = .center
        sizeLabel.text = adjustmentEngine.adjustmentName[0]
        sizeLabel.textColor = UIColor.white
        sizeLabel.font = UIFont.systemFont(ofSize: textSize, weight: UIFont.Weight.regular)
        
        sizeButton.addSubview(sizeImageView)
        sizeButton.addSubview(sizeLabel)
        
        sizeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sizeLabel.centerXAnchor.constraint(equalTo: sizeButton.centerXAnchor),
            sizeLabel.centerYAnchor.constraint(equalTo: sizeButton.centerYAnchor, constant: 30)
        ])

        // --------
        colourButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize))
        colourButton.backgroundColor = .clear
        colourButton.addTarget(self, action: #selector(colourButtonTapped), for: .touchUpInside)
        
        let colourImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageViewSize, height: imageViewSize))
        colourImageView.image = colourIcon
        colourImageView.tintColor = UIColor.white
        colourImageView.contentMode = .scaleAspectFit
        colourImageView.center = colourButton.convert(colourButton.center, to: colourImageView.superview)
        
        let colourLabel = UILabel(frame: CGRect(x: 0, y: 0, width: labelSize, height: labelSize))
        colourLabel.textAlignment = .center
        colourLabel.text = adjustmentEngine.adjustmentName[1]
        colourLabel.textColor = UIColor.white
        colourLabel.font = UIFont.systemFont(ofSize: textSize, weight: UIFont.Weight.regular)
        
        colourButton.addSubview(colourImageView)
        colourButton.addSubview(colourLabel)
        
        colourLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colourLabel.centerXAnchor.constraint(equalTo: colourButton.centerXAnchor),
            colourLabel.centerYAnchor.constraint(equalTo: colourButton.centerYAnchor, constant: 30)
        ])
        
        // --------
        ratioButton = UIButton(frame: CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize))
        ratioButton.backgroundColor = .clear
        ratioButton.addTarget(self, action: #selector(ratioButtonTapped), for: .touchUpInside)
        
        let ratioImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageViewSize, height: imageViewSize))
        ratioImageView.image = ratioIcon
        ratioImageView.tintColor = UIColor.white
        ratioImageView.contentMode = .scaleAspectFit
        ratioImageView.center = ratioButton.convert(ratioButton.center, to: colourImageView.superview)
        
        let ratioLabel = UILabel(frame: CGRect(x: 0, y: 0, width: labelSize, height: labelSize))
        ratioLabel.textAlignment = .center
        ratioLabel.text = adjustmentEngine.adjustmentName[2]
        ratioLabel.textColor = UIColor.white
        ratioLabel.font = UIFont.systemFont(ofSize: textSize, weight: UIFont.Weight.regular)
        
        ratioButton.addSubview(ratioImageView)
        ratioButton.addSubview(ratioLabel)
        
        ratioLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratioLabel.centerXAnchor.constraint(equalTo: ratioButton.centerXAnchor),
            ratioLabel.centerYAnchor.constraint(equalTo: ratioButton.centerYAnchor, constant: 30)
        ])
        

        self.editorView.addSubview(sizeButton)
        self.editorView.addSubview(colourButton)
        self.editorView.addSubview(ratioButton)
    }
    
    @objc func sizeButtonTapped(sender: UIButton!) {
        adjustmentNameLabel.text = adjustmentEngine.adjustmentName[0]
        mainButtonHide(true)
        hide(progress: nil, barItemOnEdit: false, ui: nil, slider: false, colourSelector: nil)
    }
    
    @objc func colourButtonTapped(sender: UIButton!) {
        adjustmentNameLabel.text = adjustmentEngine.adjustmentName[1]
        mainButtonHide(true)
        hide(progress: nil, barItemOnEdit: false, ui: nil, slider: nil, colourSelector: false)
    }
    
    @objc func ratioButtonTapped(sender: UIButton!) {
      print("ratio button tapped")
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
    
    // MARK: - Functions to create the Editor UI
    // create a slider for adjusting the image
    func setupAdjustmentSlider() {
        editorView.addSubview(sliderValueLabel)
        editorView.addSubview(adjustmentNameLabel)
        
        adjustmentSliderOutlet.maximumValue = 1.0
        adjustmentSliderOutlet.minimumValue = 0.5
        adjustmentSliderOutlet.value = 0.5
        
        adjustmentSliderOutlet.maximumTrackTintColor = UIColor(named: "backgroundSecondColor")
        adjustmentSliderOutlet.minimumTrackTintColor = UIColor.gray
        adjustmentSliderOutlet.thumbTintColor = UIColor.white
        
        // setup labels
        sliderValueLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        sliderValueLabel.text = "0.0 pts"
        sliderValueLabel.textColor = UIColor.white
        sliderValueLabel.textAlignment = .center
        sliderValueLabel.numberOfLines = 0
        
        adjustmentNameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        adjustmentNameLabel.textColor = UIColor.white
        adjustmentNameLabel.textAlignment = .center
        adjustmentNameLabel.numberOfLines = 0
    }
    
    // create colour selectors
    func setupColourSelector() {
        var colourSelector = ColourSelector(editorViewW: editorView.frame.width, editorViewH: editorView.frame.height, viewFrameH: view.frame.height, heightMultConst: VIEW_HEIGHTMULTIPLIER_CONSTANT)
        
        // add to subview
        editorView.addSubview(adjustmentNameLabel)
        editorView.addSubview(colourSelectorScrollView)
        colourSelectorScrollView.showsHorizontalScrollIndicator = false
        
        // instantiate
        let colourButtons: [UIButton] = colourSelector.createButtonArray()
        
        for colourButton in colourButtons {
            colourButton.addTarget(self, action: #selector(colourTapped), for: .touchUpInside)
            colourSelectorScrollView.addSubview(colourButton)
        }
        
        // rearrange to fit the content
        colourSelectorScrollView.contentSize = CGSize(width: colourSelector.buttonWidth * CGFloat(Double(colourSelector.colourName.count) + 1.3), height: colourSelectorScrollView.frame.height)
    }
    
    // function when a colour is tapped
    @objc func colourTapped(sender: UIButton) {
        let borderColor = sender.backgroundColor!
        borderView.backgroundColor = borderColor
    }
    
    // MARK: - Hide elements function
    func hide(progress: Bool?, barItemOnEdit: Bool?, ui: Bool?, slider: Bool?, colourSelector: Bool?) {
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
            adjustmentSliderOutlet.isHidden = slider
            sliderValueLabel.isHidden = slider
            adjustmentNameLabel.isHidden = slider
        }
        if let colourSelector = colourSelector {
            adjustmentNameLabel.isHidden = colourSelector
            colourSelectorScrollView.isHidden = colourSelector
        }
    }
    
    
    // this function is to hide the main buttons for showing detailed panel.
    func mainButtonHide(_ bool: Bool) {
        colourButton.isHidden = bool
        sizeButton.isHidden = bool
        ratioButton.isHidden = bool
}

    
    // MARK: - Constraints
    func setupConstraint() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.6)
            ])
        
        imageViewTop.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageViewTop.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45),
            imageViewTop.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageViewTop.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 5),
            imageViewTop.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -5),
            imageViewTop.heightAnchor.constraint(equalToConstant: view.frame.height * 0.6)
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
        
        sizeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sizeButton.centerXAnchor.constraint(equalTo: editorView.centerXAnchor, constant: -130),
            sizeButton.centerYAnchor.constraint(equalTo: editorView.centerYAnchor ,constant: -5),
            sizeButton.heightAnchor.constraint(equalToConstant: 130),
            sizeButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        colourButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colourButton.centerXAnchor.constraint(equalTo: editorView.centerXAnchor),
            colourButton.centerYAnchor.constraint(equalTo: editorView.centerYAnchor, constant: -5),
            colourButton.heightAnchor.constraint(equalToConstant: 130),
            colourButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        ratioButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratioButton.centerXAnchor.constraint(equalTo: editorView.centerXAnchor, constant: 130),
            ratioButton.centerYAnchor.constraint(equalTo: editorView.centerYAnchor, constant: -5),
            ratioButton.heightAnchor.constraint(equalToConstant: 130),
            ratioButton.widthAnchor.constraint(equalToConstant: 100)
        ])

        barView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            barView.topAnchor.constraint(equalTo: editorView.bottomAnchor),
            barView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            barView.leftAnchor.constraint(equalTo: view.leftAnchor),
            barView.rightAnchor.constraint(equalTo: view.rightAnchor),
            barView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        
        // setup the constraints for the labels and slider.
        adjustmentSliderOutlet.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            adjustmentSliderOutlet.topAnchor.constraint(equalTo: editorView.topAnchor, constant: 40),
            adjustmentSliderOutlet.centerXAnchor.constraint(equalTo: editorView.centerXAnchor),
            adjustmentSliderOutlet.widthAnchor.constraint(equalToConstant: editorView.frame.height * 1.6),
            adjustmentSliderOutlet.heightAnchor.constraint(equalToConstant: editorView.frame.height * 0.2)
            ])
        
        sliderValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sliderValueLabel.topAnchor.constraint(equalTo: adjustmentSliderOutlet.bottomAnchor, constant: 10),
            sliderValueLabel.centerXAnchor.constraint(equalTo: adjustmentSliderOutlet.centerXAnchor)
            ])
        
        adjustmentNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            adjustmentNameLabel.bottomAnchor.constraint(equalTo: adjustmentSliderOutlet.topAnchor, constant: -15),
            adjustmentNameLabel.centerXAnchor.constraint(equalTo: editorView.centerXAnchor)
            ])
        
        colourSelectorScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colourSelectorScrollView.topAnchor.constraint(equalTo: editorView.topAnchor),
            colourSelectorScrollView.leftAnchor.constraint(equalTo: editorView.leftAnchor),
            colourSelectorScrollView.rightAnchor.constraint(equalTo: editorView.rightAnchor),
            colourSelectorScrollView.bottomAnchor.constraint(equalTo: editorView.bottomAnchor)
        ])
    }
    
}
