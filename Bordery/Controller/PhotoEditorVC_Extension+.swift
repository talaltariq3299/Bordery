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
    
    //------------------------------
    // MARK: - Main buttons
    // main buttons for the app
    func setupMainButtons() {
        // variables
        let sizeIcon = UIImage(named: "size-icon")!.withRenderingMode(.alwaysTemplate)
        let colourIcon = UIImage(named: "colour-icon")!.withRenderingMode(.alwaysTemplate)
        let ratioIcon = UIImage(named: "ratio-icon")!.withRenderingMode(.alwaysTemplate)
        
        sizeButton = MainButton.createButton(buttonIcon: sizeIcon, buttonName: borderEngine.adjustmentName[0])
        sizeButton.addTarget(self, action: #selector(sizeButtonTapped), for: .touchUpInside)
        sizeButton.addTarget(self, action: #selector(buttonHighlighted), for: .touchDown)
        sizeButton.addTarget(self, action: #selector(buttonNormal), for: .touchDragExit)
        
        colourButton = MainButton.createButton(buttonIcon: colourIcon, buttonName: borderEngine.adjustmentName[1])
        colourButton.addTarget(self, action: #selector(colourButtonTapped), for: .touchUpInside)
        colourButton.addTarget(self, action: #selector(buttonHighlighted), for: .touchDown)
        colourButton.addTarget(self, action: #selector(buttonNormal), for: .touchDragExit)
        
        ratioButton = MainButton.createButton(buttonIcon: ratioIcon, buttonName: borderEngine.adjustmentName[2])
        ratioButton.addTarget(self, action: #selector(ratioButtonTapped), for: .touchUpInside)
        ratioButton.addTarget(self, action: #selector(buttonHighlighted), for: .touchDown)
        ratioButton.addTarget(self, action: #selector(buttonNormal), for: .touchDragExit)
        
        self.editorView.addSubview(sizeButton)
        self.editorView.addSubview(colourButton)
        self.editorView.addSubview(ratioButton)
    }
    
    //------------------------------
    // MARK: - Main buttons components
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
    }
    
    // create colour selectors
    func setupColourSelector() {
        colourSelector = ColourEngine(editorViewW: editorView.frame.width, editorViewH: editorView.frame.height, viewFrameH: view.frame.height, heightMultConst: VIEW_HEIGHTMULTIPLIER_CONSTANT)
        
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
    }
    
    // create export buttons
    func setupExportSelector() {
        exportSelector = ExportEngine(editorViewW: editorView.frame.width, editorViewH: editorView.frame.height, viewFrameH: view.frame.height, heightMultConst: VIEW_HEIGHTMULTIPLIER_CONSTANT)
        
        // add to subview
        editorView.addSubview(exportSelectorScrollView)
        editorView.addSubview(adjustmentNameLabel)
        exportSelectorScrollView.showsHorizontalScrollIndicator = false
        
        // instantiate
        let exportButtons: [UIButton] = exportSelector.createButtonArray()
        
        for exportButton in exportButtons {
            exportSelectorScrollView.addSubview(exportButton)
            exportButton.addTarget(self, action: #selector(exportTapped), for: .touchUpInside)
        }
        
        // rearrange to fit the content
        exportSelectorScrollView.contentSize = CGSize(width: exportSelector.buttonWidth * CGFloat(Double(exportSelector.exportName.count) + 0.6), height: exportSelectorScrollView.frame.height)
    }
    
    // create ratio selectors
    func setupRatioSelector() {
        ratioSelector = RatioEngine(editorViewW: editorView.frame.width, editorViewH: editorView.frame.height, viewFrameH: view.frame.height, heightMultConst: VIEW_HEIGHTMULTIPLIER_CONSTANT)
        
        // add to subview
        editorView.addSubview(adjustmentNameLabel)
        editorView.addSubview(ratioSelectorScrollView)
        barView.addSubview(noticeLabel)
        ratioSelectorScrollView.showsHorizontalScrollIndicator = false
        
        // instantiate
        let ratioButtons: [UIButton] = ratioSelector.createButtonArray()
        
        for ratioButton in ratioButtons {
            ratioButton.addTarget(self, action: #selector(ratioTapped), for: .touchUpInside)
            ratioSelectorScrollView.addSubview(ratioButton)
        }
        
        // rearrange to fit the content
        ratioSelectorScrollView.contentSize = CGSize(width: ratioSelector.buttonWidth * CGFloat(Double(ratioSelector.ratioName.count) + 1.3), height: colourSelectorScrollView.frame.height)
    }
    
    //------------------------------
    // MARK: - Menu bar
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
        
        let cancelButton = BarItemEdit.createBarItemButton(title: "☓")
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(buttonHighlighted), for: .touchDown)
        cancelButton.addTarget(self, action: #selector(buttonNormal), for: .touchDragExit)
        let cancelButtonWrapper = UIView()
        cancelButtonWrapper.addSubview(cancelButton)
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: cancelButtonWrapper.topAnchor, constant: 5),
            cancelButton.bottomAnchor.constraint(equalTo: cancelButtonWrapper.bottomAnchor, constant: -5),
            cancelButton.leftAnchor.constraint(equalTo: cancelButtonWrapper.leftAnchor, constant: 5),
            cancelButton.rightAnchor.constraint(equalTo: cancelButtonWrapper.rightAnchor, constant: -5)
        ])
        
        let checkButton = BarItemEdit.createBarItemButton(title: "✓")
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        checkButton.addTarget(self, action: #selector(buttonHighlighted), for: .touchDown)
        checkButton.addTarget(self, action: #selector(buttonNormal), for: .touchDragExit)
        let checkButtonWrapper = UIView()
        checkButtonWrapper.addSubview(checkButton)
        
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkButton.topAnchor.constraint(equalTo: checkButtonWrapper.topAnchor, constant: 5),
            checkButton.bottomAnchor.constraint(equalTo: checkButtonWrapper.bottomAnchor, constant: -5),
            checkButton.leftAnchor.constraint(equalTo: checkButtonWrapper.leftAnchor, constant: 5),
            checkButton.rightAnchor.constraint(equalTo: checkButtonWrapper.rightAnchor, constant: -5)
        ])
        
        barItemOnEditStackView.addArrangedSubview(cancelButtonWrapper)
        barItemOnEditStackView.addArrangedSubview(checkButtonWrapper)
        
        
    }

    // create main menu bar
    func setupMenuBar() {
        let saveIcon = UIImage(named: "save-icon")!.withRenderingMode(.alwaysTemplate)
        let borderIcon = UIImage(named: "border-icon")!.withRenderingMode(.alwaysTemplate)
        let adjustmentIcon = UIImage(named: "adjustment-icon")!.withRenderingMode(.alwaysTemplate)
        
        borderButton = MenuBarButton.createButton(buttonIcon: borderIcon, buttonTag: 0, isActive: true)
        borderButton.addTarget(self, action: #selector(menuBarTapped), for: .touchUpInside)
        
        saveButton = MenuBarButton.createButton(buttonIcon: saveIcon, buttonTag: 1, isActive: false)
        saveButton.addTarget(self, action: #selector(menuBarTapped), for: .touchUpInside)
        
        adjustmentButton = MenuBarButton.createButton(buttonIcon: adjustmentIcon, buttonTag: 2, isActive: false)
        adjustmentButton.addTarget(self, action: #selector(menuBarTapped), for: .touchUpInside)

        self.barView.addSubview(borderButton)
        self.barView.addSubview(saveButton)
        self.barView.addSubview(adjustmentButton)
    }
    
    
    // MARK: - Hide elements function
    func hide(progress: Bool?, barItemOnEdit: Bool?, ui: Bool?, slider: Bool?, colourSelector: Bool?, ratioSelector: Bool?) {
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
        if let ratioSelector = ratioSelector {
            adjustmentNameLabel.isHidden = ratioSelector
            ratioSelectorScrollView.isHidden = ratioSelector
        }
    }
    
    func exportButtonHide(_ bool: Bool) {
        adjustmentNameLabel.isHidden = bool
        exportSelectorScrollView.isHidden = bool
    }

    // this function is to hide the main buttons for showing detailed panel.
    func mainButtonHide(_ bool: Bool) {
        colourButton.isHidden = bool
        sizeButton.isHidden = bool
        ratioButton.isHidden = bool
    }
    
    // this function is to hide the menu bar buttons.
    func menuBarHide(_ bool: Bool) {
        borderButton.isHidden = bool
        saveButton.isHidden = bool
        adjustmentButton.isHidden = bool
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
            sizeButton.heightAnchor.constraint(equalToConstant: 120),
            sizeButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        colourButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colourButton.centerXAnchor.constraint(equalTo: editorView.centerXAnchor),
            colourButton.centerYAnchor.constraint(equalTo: editorView.centerYAnchor, constant: -5),
            colourButton.heightAnchor.constraint(equalToConstant: 120),
            colourButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        ratioButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratioButton.centerXAnchor.constraint(equalTo: editorView.centerXAnchor, constant: 130),
            ratioButton.centerYAnchor.constraint(equalTo: editorView.centerYAnchor, constant: -5),
            ratioButton.heightAnchor.constraint(equalToConstant: 120),
            ratioButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        barView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            barView.heightAnchor.constraint(equalToConstant: 49),
            barView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            barView.leftAnchor.constraint(equalTo: view.leftAnchor),
            barView.rightAnchor.constraint(equalTo: view.rightAnchor),
            barView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // setup the constraints for the labels and slider.
        adjustmentSliderOutlet.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            adjustmentSliderOutlet.topAnchor.constraint(equalTo: editorView.topAnchor, constant: 50),
            adjustmentSliderOutlet.centerXAnchor.constraint(equalTo: editorView.centerXAnchor),
            adjustmentSliderOutlet.widthAnchor.constraint(equalToConstant: editorView.frame.height * 1.6),
            adjustmentSliderOutlet.heightAnchor.constraint(equalToConstant: editorView.frame.height * 0.2)
        ])
        
        sliderValueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sliderValueLabel.topAnchor.constraint(equalTo: adjustmentSliderOutlet.bottomAnchor, constant: 8),
            sliderValueLabel.centerXAnchor.constraint(equalTo: adjustmentSliderOutlet.centerXAnchor)
        ])
        
        adjustmentNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            adjustmentNameLabel.topAnchor.constraint(equalTo: editorView.topAnchor, constant: 15),
            adjustmentNameLabel.centerXAnchor.constraint(equalTo: editorView.centerXAnchor)
        ])
        
        colourSelectorScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            colourSelectorScrollView.topAnchor.constraint(equalTo: editorView.topAnchor),
            colourSelectorScrollView.leftAnchor.constraint(equalTo: editorView.leftAnchor),
            colourSelectorScrollView.rightAnchor.constraint(equalTo: editorView.rightAnchor),
            colourSelectorScrollView.bottomAnchor.constraint(equalTo: editorView.bottomAnchor)
        ])
        
        ratioSelectorScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ratioSelectorScrollView.topAnchor.constraint(equalTo: editorView.topAnchor),
            ratioSelectorScrollView.leftAnchor.constraint(equalTo: editorView.leftAnchor),
            ratioSelectorScrollView.rightAnchor.constraint(equalTo: editorView.rightAnchor),
            ratioSelectorScrollView.bottomAnchor.constraint(equalTo: editorView.bottomAnchor)
        ])
        
        exportSelectorScrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exportSelectorScrollView.topAnchor.constraint(equalTo: editorView.topAnchor),
            exportSelectorScrollView.leftAnchor.constraint(equalTo: editorView.leftAnchor),
            exportSelectorScrollView.rightAnchor.constraint(equalTo: editorView.rightAnchor),
            exportSelectorScrollView.bottomAnchor.constraint(equalTo: editorView.bottomAnchor)
        ])
        
        borderButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            borderButton.widthAnchor.constraint(equalTo: barView.widthAnchor, multiplier: 0.33),
            borderButton.leftAnchor.constraint(equalTo: barView.leftAnchor, constant: 0),
            borderButton.heightAnchor.constraint(equalTo: barView.heightAnchor)
        ])
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.widthAnchor.constraint(equalTo: barView.widthAnchor, multiplier: 0.33),
            saveButton.rightAnchor.constraint(equalTo: barView.rightAnchor, constant: 0),
            saveButton.heightAnchor.constraint(equalTo: barView.heightAnchor)
        ])
        
        adjustmentButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            adjustmentButton.widthAnchor.constraint(equalTo: barView.widthAnchor, multiplier: 0.33),
            adjustmentButton.centerXAnchor.constraint(equalTo: barView.centerXAnchor, constant: 0),
            adjustmentButton.heightAnchor.constraint(equalTo: barView.heightAnchor),
        ])
        
        noticeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noticeLabel.centerXAnchor.constraint(equalTo: barView.centerXAnchor),
            noticeLabel.centerYAnchor.constraint(equalTo: barView.centerYAnchor),
            noticeLabel.leftAnchor.constraint(equalTo: barView.leftAnchor, constant: 10),
            noticeLabel.rightAnchor.constraint(equalTo: barView.rightAnchor, constant: -10)
        ])
    }
    
    // from https://stackoverflow.com/questions/17355280/how-to-add-a-border-just-on-the-top-side-of-a-uiview
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat, to: UIView) -> UIView {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: to.frame.size.width, height: borderWidth)
        
        return border
    }
    
    
    // MARK: - Objc Functions
    @objc func sizeButtonTapped(sender: UIButton!) {
        TapticEngine.lightTaptic()
        sender.tintColor = .white
        adjustmentNameLabel.text = borderEngine.adjustmentName[0]
        mainButtonHide(true)
        menuBarHide(true)
        hide(progress: nil, barItemOnEdit: false, ui: nil, slider: false, colourSelector: nil, ratioSelector: nil)
    }
    
    @objc func colourButtonTapped(sender: UIButton!) {
        TapticEngine.lightTaptic()
        sender.tintColor = .white
        adjustmentNameLabel.text = borderEngine.adjustmentName[1]
        mainButtonHide(true)
        menuBarHide(true)
        hide(progress: nil, barItemOnEdit: false, ui: nil, slider: nil, colourSelector: false, ratioSelector: nil)
    }
    
    @objc func ratioButtonTapped(sender: UIButton!) {
        TapticEngine.lightTaptic()
        sender.tintColor = .white
        adjustmentNameLabel.text = borderEngine.adjustmentName[2]
        mainButtonHide(true)
        menuBarHide(true)
        noticeLabel.isHidden = false
        hide(progress: nil, barItemOnEdit: nil, ui: nil, slider: nil, colourSelector: nil, ratioSelector: false)
    }
    
    // when user select a button but didnt press it.
    @objc func buttonHighlighted(sender: UIButton!) {
        sender.tintColor = .lightGray
        sender.setTitleColor(.lightGray, for: .normal)
    }
    
    // when user drag their finger outside the button
    @objc func buttonNormal(sender: UIButton!) {
        sender.tintColor = .white
        sender.setTitleColor(.white, for: .normal)
    }
    
    @objc func exportTapped(sender: UIButton) {
        sender.tintColor = .white
        let finalImageData = borderEngine.blendImages(backgroundImg: borderView.asImage(), foregroundImg: imageViewTop.image!)!
        guard let finalImage = UIImage(data: finalImageData) else {
            AlertService.alert(self, title: "oof!", message: "It appears that the export engine is not working. Try again later or submit a bug report!")
            return
        }
        
        switch sender.tag {
        case 0:
            CustomPhotoAlbum.shared.save(image: finalImage) { (success) in
                if success {
                    TapticEngine.successTaptic()
                    DispatchQueue.main.async {
                        AlertService.alert(self, title: "Hooray!", message: "Your photo has been successfully saved!")
                    }
                    
                }
                else {
                    DispatchQueue.main.async {
                        TapticEngine.errorTaptic()
                        AlertService.alert(self, title: "Oops!", message: "Something went wrong while we tried to save your photo!")
                    }
                }
            }
            
        case 1:
            // image to share
            let image = finalImage
            
            // set up activity view controller
            let imageToShare = [image]
            let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
            
            // present the view controller
            self.present(activityViewController, animated: true, completion: nil)
            
            
        default:
            print("Default")
            
        }
    }
    
    @objc func menuBarTapped(sender: UIButton) {
        switch sender.tag {
        case 0:
            borderButton.tintColor = .white
            saveButton.tintColor = .darkGray
            adjustmentButton.tintColor = .darkGray
            
            mainButtonHide(false)
            exportButtonHide(true)
        case 1:
            adjustmentNameLabel.text = "Export"
            borderButton.tintColor = .darkGray
            saveButton.tintColor = .white
            adjustmentButton.tintColor = .darkGray
            
            mainButtonHide(true)
            exportButtonHide(false)
        case 2:
            adjustmentNameLabel.text = "Effects"
            borderButton.tintColor = .darkGray
            saveButton.tintColor = .darkGray
            adjustmentButton.tintColor = .white
            
            mainButtonHide(true)
        default:
            print("barButtonTapped default.")
        }
    }
    
    // function when a colour is tapped
    @objc func colourTapped(sender: UIButton) {
        TapticEngine.lightTaptic()
        
        let borderColor = sender.backgroundColor!
        borderView.backgroundColor = borderColor
    }
    
    @objc func ratioTapped(sender: UIButton) {
        if sender.titleLabel?.text != "override" {
            TapticEngine.lightTaptic()
        }
        
        if oriImage.size.width == oriImage.size.height {
            sender.tag = 1
        }
        
        sender.tintColor = .white
        noticeLabel.isHidden = true
        
        switch sender.tag {
        case 0:
            imageViewTop.image = oriImage
            borderView.frame = imageViewTop.contentClippingRect
            let renderImage = borderEngine.createRenderImage(foregroundImage: oriImage, backgroundImageFrame: borderView.frame)
            imageViewTop.image = renderImage
            
        case 1:
            // from the original size's perspective
            borderView.frame = imageViewTop.contentClippingRect
            // get the difference to make the border square
            let heightDiff = borderView.frame.size.width - borderView.frame.size.height
            // move the y point the same amount the height added.
            let reducedYPt = borderView.frame.minY - heightDiff / 2
            borderView.frame.size.height = borderView.frame.size.width
            // transform.
            borderView.frame = CGRect(x: 0, y: reducedYPt, width: imageView.frame.width, height: imageView.frame.width)
            borderView.center = CGPoint(x: imageView.frame.size.width  / 2, y: imageView.frame.size.height / 2)
            
            // scale accordingly.
            // square portrait or square square
            if oriImage.size.width < oriImage.size.height || oriImage.size.width == oriImage.size.height {
                let renderImage = borderEngine.createRenderImageSquare(foregroundImage: oriImage, backgroundImageFrame: borderView.frame)
                imageViewTop.image = renderImage
            }
            
        case 2:
            print("No value found!")
            //                // preserve ratio
            //                let newW = 9 * imageView.frame.height / 16
            //                borderView.frame = CGRect(x: 0, y: 0, width: newW, height: imageView.frame.height)
            //                borderView.center = CGPoint(x: imageView.frame.width  / 2, y: imageView.frame.height / 2)
            //
            //                if oriImage.size.width > oriImage.size.height {
            //                    let renderImage = borderEngine.createRenderImagePortrait(foregroundImage: oriImage, backgroundImageFrame: borderView.frame)
            //                    imageViewTop.image = renderImage
            //                }
            //                // portrait portrait
            //                else {
            //                    let renderImage = borderEngine.createRenderImagePortrait(foregroundImage: oriImage, backgroundImageFrame: borderView.frame)
            //                    imageViewTop.image = renderImage
            //                }
            
        default:
            print("No tag matches! ratioTapped function on PhotoEditorVC Extension+")
        }
        
        hide(progress: nil, barItemOnEdit: nil, ui: nil, slider: nil, colourSelector: nil, ratioSelector: true)
        mainButtonHide(false)
        menuBarHide(false)
    }
}
